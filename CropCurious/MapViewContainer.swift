import SwiftUI
import MapKit

struct MapViewContainer: UIViewRepresentable {
    // Optional bindings for interaction
    @Binding var selectedField: Field?
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

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeOverlays(uiView.overlays)

        for field in cropFields {
            let polygon = MKPolygon(coordinates: field.fieldBoundary, count: field.fieldBoundary.count)
            polygon.title = field.crops.first?.name
            uiView.addOverlay(polygon)
        }
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewContainer

        init(_ parent: MapViewContainer) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            guard let polygon = overlay as? MKPolygon else {
                return MKOverlayRenderer()
            }

            let renderer = MKPolygonRenderer(polygon: polygon)
            renderer.fillColor = UIColor.systemPink.withAlphaComponent(0.5)
            return renderer
        }

        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            print("Annotation selected")
        }

        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            // This is where you'd detect visible fields or trigger loading logic
        }
    }
}
