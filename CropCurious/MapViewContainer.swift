import SwiftUI
import MapKit


enum SelectedCrop: Identifiable {
    case corn, beets, kale, potatoes, romaine, spinach, strawberries, wheat
    var id: Self { self }
    var label: String {
        switch self {
        case .corn:
            return "Corn"
        case .beets:
            return "Beets"
        case .kale:
            return "Kale"
        case .potatoes:
            return "Potatoes"
        case .romaine:
            return "Romaine"
        case .spinach:
            return "Spinach"
        case .strawberries:
            return "Strawberries"
        case .wheat:
            return "Wheat"
        }
    }
    var thumbnail: Image {
        switch self {
        case .corn:
            return Image("corn")
        case .beets:
            return Image("beets")
        case .kale:
            return Image("kale")
        case .potatoes:
            return Image("potatoes")
        case .romaine:
            return Image("romaine")
        case .spinach:
            return Image("spinach")
        case .strawberries:
            return Image("strawberries")
        case .wheat:
            return Image("wheat")
        }
    }
}

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
        uiView.removeOverlays(uiView.overlays)
        uiView.removeAnnotations(uiView.annotations)

        for field in cropFields {
            let polygon = MKPolygon(coordinates: field.fieldBoundary, count: field.fieldBoundary.count)
            polygon.title = field.id.description
            uiView.addOverlay(polygon)
            
            // Add custom placemark
            let annotation = MKPointAnnotation()
            annotation.coordinate = field.placemarkCoor
            annotation.title = field.crops.first?.type.label ?? ""
            uiView.addAnnotation(annotation)
        }
    }

    class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
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
                renderer.fillColor = UIColor.systemGreen.withAlphaComponent(0.5)
            } else {
                renderer.fillColor = UIColor.clear
            }

            rendererCache[polygon] = renderer
            return renderer
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
                }
            } else {
                // Deselect and hide
                if parent.viewModel.selectedPolygonTitle != nil {
                    withAnimation {
                        parent.viewModel.dynamicOffset = 200
                        parent.viewModel.searchDynamicOffset = 700
                        self.updateSelection(on: mapView, selected: nil)
                    }
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
