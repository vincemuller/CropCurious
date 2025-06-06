import SwiftUI
import MapKit



struct MapViewContainer: UIViewRepresentable {
    // Optional bindings for interaction
    @EnvironmentObject var viewModel: ViewModel
    var cropFields: [Field]

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .none

        context.coordinator.mapView = mapView

        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
        mapView.addGestureRecognizer(tapGesture)

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        let newFieldIDs = Set(cropFields.map { $0.id })

        context.coordinator.currentFieldIDs = newFieldIDs

        uiView.removeOverlays(uiView.overlays)
        uiView.removeAnnotations(uiView.annotations)

        for field in cropFields {
            let polygon = MKPolygon(coordinates: field.fieldBoundary, count: field.fieldBoundary.count)
            polygon.title = field.id.description
            uiView.addOverlay(polygon)

            let annotation = MKPointAnnotation()
            annotation.coordinate = field.placemarkCoor
            annotation.title = field.crops.first?.type.label ?? ""
            uiView.addAnnotation(annotation)
        }
        
        if viewModel.recenterUserLocation,
           let location = viewModel.userLocation {
            let center = location.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
            let region = MKCoordinateRegion(center: center, span: span)
            uiView.setRegion(region, animated: true)

            // Reset the trigger flag
            DispatchQueue.main.async {
                self.viewModel.recenterUserLocation = false
            }
        }
        
        if viewModel.searchActive {
            context.coordinator.zoomToFitFields(cropFields, in: uiView)
            DispatchQueue.main.async {
                self.viewModel.searchActive = false
            }
        }
        
        print("Overlay count: \(uiView.overlays.count), Fields: \(cropFields.count)")

    }

    class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
        var currentFieldIDs: Set<UUID> = []
        var parent: MapViewContainer
        var polygons: [MKPolygon] = []
        var rendererCache: [MKPolygon: MKPolygonRenderer] = [:]
        var mapView: MKMapView?
        let locationManager = CLLocationManager()

        init(_ parent: MapViewContainer) {
            self.parent = parent
            super.init()
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        // MARK: - MKMapViewDelegate
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            guard let polygon = overlay as? MKPolygon else {
                return MKOverlayRenderer()
            }

            // Cache polygon for hit-testing
            if !polygons.contains(polygon) {
                polygons.append(polygon)
            }

            // Use cached renderer if available
            if let cached = rendererCache[polygon] {
                return cached
            }

            let renderer = MKPolygonRenderer(polygon: polygon)
            renderer.strokeColor = UIColor.black.withAlphaComponent(0.5)
            renderer.lineWidth = 0.5
            renderer.lineDashPattern = [3]

            // Fill color based on selection
            if polygon.title == parent.viewModel.selectedPolygonTitle {
                renderer.fillColor = UIColor.systemGreen.withAlphaComponent(0.75)
            } else {
                renderer.fillColor = UIColor.clear
            }

            rendererCache[polygon] = renderer
            return renderer
        }
        
        func zoomToFitFields(_ fields: [Field], in mapView: MKMapView) {
            let coordinates = fields.flatMap { $0.fieldBoundary }

            guard !coordinates.isEmpty else { return }

            var zoomRect = MKMapRect.null
            for coordinate in coordinates {
                let point = MKMapPoint(coordinate)
                let rect = MKMapRect(x: point.x, y: point.y, width: 0.1, height: 0.1)
                zoomRect = zoomRect.union(rect)
            }

            mapView.setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 80, left: 50, bottom: 250, right: 50), animated: true)
            
        }

        
        func invalidateRenderers() {
            guard let mapView = mapView else { return }

            rendererCache.removeAll()
            let overlays = mapView.overlays
            mapView.removeOverlays(overlays)
            mapView.addOverlays(overlays)
        }

        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            }

            let identifier = "MarkerAnnotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView

            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.markerTintColor = .systemGreen.withAlphaComponent(0.7)
            annotationView?.glyphText = {
                switch annotation.title ?? "" {
                case "Corn": return "🌽"
                case "Potatoes": return "🥔"
                case "Kale", "Romaine", "Spinach": return "🥬"
                case "Strawberries": return "🍓"
                case "Wheat": return "🌾"
                default: return "🌱"
                }
            }()
            annotationView?.titleVisibility = .adaptive
            annotationView?.subtitleVisibility = .adaptive

            return annotationView
        }

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let mapView = mapView else { return }
            guard let location = locations.first else { return }
            
            parent.viewModel.userLocation = location
            parent.viewModel.fieldSearch()

            let center = location.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
            let region = MKCoordinateRegion(center: center, span: span)
            mapView.setRegion(region, animated: true)

            // Stop updating location after setting initial view
            locationManager.stopUpdatingLocation()
        }

        // MARK: - Tap Handler
        @objc func handleTap(_ sender: UITapGestureRecognizer) {
            guard let mapView = sender.view as? MKMapView else { return }

            let tapPoint = sender.location(in: mapView)
            let tapCoordinate = mapView.convert(tapPoint, toCoordinateFrom: mapView)

            var tappedPolygon: MKPolygon?

            for polygon in polygons {
                guard let renderer = rendererCache[polygon] else { continue }

                let mapPoint = MKMapPoint(tapCoordinate)
                let pointInRenderer = renderer.point(for: mapPoint)

                if renderer.path.contains(pointInRenderer) {
                    tappedPolygon = polygon
                    break
                }
            }

            if let polygon = tappedPolygon {
                // Haptic feedback
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.prepare()
                generator.impactOccurred()

                // Always show bottom sheet
                parent.viewModel.selectedField = polygon.title
                withAnimation(.spring) {
                    parent.viewModel.searchDynamicOffset = 900
                    parent.viewModel.dynamicOffset = 0
                }


                // Only update visuals if selection changed
                if parent.viewModel.selectedPolygonTitle != polygon.title {
                    updateSelection(on: mapView, selected: polygon)
                    invalidateRenderers()
                }
            } else {
                // Deselect and hide
                if parent.viewModel.selectedPolygonTitle != nil {
                    withAnimation {
                        parent.viewModel.dynamicOffset = 200
                        parent.viewModel.searchDynamicOffset = 700
                        self.updateSelection(on: mapView, selected: nil)
                    }
                    invalidateRenderers()
                }
            }
        }

        // MARK: - Selection Update
        private func updateSelection(on mapView: MKMapView, selected newSelection: MKPolygon?) {
            // Remove previous if any
            if let currentTitle = parent.viewModel.selectedPolygonTitle,
               let previous = polygons.first(where: { $0.title == currentTitle }) {
                mapView.removeOverlay(previous)
                rendererCache[previous] = nil
                mapView.addOverlay(previous)
            }

            // Add new if any
            if let new = newSelection {
                mapView.removeOverlay(new)
                parent.viewModel.selectedPolygonTitle = new.title
                rendererCache[new] = nil
                mapView.addOverlay(new)
            } else {
                parent.viewModel.selectedPolygonTitle = nil
            }
        }
    }

}
