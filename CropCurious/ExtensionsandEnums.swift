//
//  ExtensionsandEnums.swift
//  CropCurious
//
//  Created by Vince Muller on 5/30/25.
//

import Foundation
import MapKit
import SwiftUI


extension Field {
    func distance(to location: CLLocation) -> CLLocationDistance {
        let fieldLocation = CLLocation(latitude: placemarkCoor.latitude, longitude: placemarkCoor.longitude)
        return fieldLocation.distance(from: location) // in meters
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

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
