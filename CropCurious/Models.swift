//
//  Models.swift
//  CropCurious
//
//  Created by Vince Muller on 5/18/25.
//

import Foundation
import MapKit


struct Field: Identifiable {
    var id = UUID()
    var acreSize: Double
    var farm: Farm
    var crops: [Crop]
    var fieldBoundary: [CLLocationCoordinate2D]
}

struct Farm: Identifiable {
    var id = UUID()
    var name: String
    var location: String
}

struct Crop: Identifiable {
    var id = UUID()
    var name: String
    var datePlanted: Date
    var estimatedHarvestDate: Date
}
