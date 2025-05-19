//
//  Models.swift
//  CropCurious
//
//  Created by Vince Muller on 5/18/25.
//

import Foundation


struct Field: Identifiable {
    var id = UUID()
    var acreSize: Double
    var farm: [Farm]
    var crops: [Crop]
    var fieldBoundary: [String]
}

struct Farm: Identifiable {
    var id = UUID()
    var name: String
    var location: String
    var fields: [Field]
}

struct Crop: Identifiable {
    var id = UUID()
    var name: String
    var datePlanted: Date
    var estimatedHarvestDate: Date
}
