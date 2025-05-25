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

        // 🌍 Set initial region — center on the sample polygon
        let center = CLLocationCoordinate2D(latitude: 33.454300, longitude: -112.519400)
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: false)
        
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
        mapView.addGestureRecognizer(tapGesture)

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeOverlays(uiView.overlays)

        for field in cropFields {
            let polygon = MKPolygon(coordinates: field.fieldBoundary, count: field.fieldBoundary.count)
            polygon.title = field.id.description
            uiView.addOverlay(polygon)
        }
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewContainer
        var polygons: [MKPolygon] = []
        var rendererCache: [MKPolygon: MKPolygonRenderer] = [:]
        var selectedPolygonTitle: String?

        init(_ parent: MapViewContainer) {
            self.parent = parent
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
            if polygon.title == selectedPolygonTitle {
                renderer.fillColor = UIColor.systemGreen.withAlphaComponent(0.5)
            } else {
                renderer.fillColor = UIColor.clear
            }

            rendererCache[polygon] = renderer
            return renderer
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
//                parent.viewModel.cropDetailSheetPresenting = true

                // Only update visuals if selection changed
                if selectedPolygonTitle != polygon.title {
                    updateSelection(on: mapView, selected: polygon)
                }
            } else {
                // Deselect and hide
                if selectedPolygonTitle != nil {
                    updateSelection(on: mapView, selected: nil)
                    parent.viewModel.selectedField = nil
                    parent.viewModel.cropDetailSheetPresenting = false
                }
            }
        }

        // MARK: - Selection Update
        private func updateSelection(on mapView: MKMapView, selected newSelection: MKPolygon?) {
            // Remove previous if any
            if let currentTitle = selectedPolygonTitle,
               let previous = polygons.first(where: { $0.title == currentTitle }) {
                mapView.removeOverlay(previous)
                rendererCache[previous] = nil
                mapView.addOverlay(previous)
            }

            // Add new if any
            if let new = newSelection {
                mapView.removeOverlay(new)
                selectedPolygonTitle = new.title
                rendererCache[new] = nil
                mapView.addOverlay(new)
            } else {
                selectedPolygonTitle = nil
            }
        }
    }

}
