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
    var placemarkCoor: CLLocationCoordinate2D
    var fieldBoundary: [CLLocationCoordinate2D]
}

struct Farm: Identifiable {
    var id = UUID()
    var name: String
    var location: String
}

struct Crop: Identifiable {
    var id = UUID()
    var type: SelectedCrop
    var datePlanted: Date
    var estimatedHarvestDate: Date
}

struct SampleFields {
    static let data: [Field] = [
        Field(acreSize: 7, farm: Farm(name: "Clarkson Farm", location: "Buckeye, Arizona"), crops: [Crop(type: .potatoes, datePlanted: Date.now, estimatedHarvestDate: Date.now)], placemarkCoor: CLLocationCoordinate2D(latitude: 33.46107401968415, longitude: -112.51855992962584), fieldBoundary: [
            CLLocationCoordinate2D(latitude: 33.464434886242586,longitude: -112.49530481220827),
            CLLocationCoordinate2D(latitude: 33.46280120976414,longitude: -112.49530481220827),
            CLLocationCoordinate2D(latitude: 33.46280120976414,longitude: -112.49271007761436),
            CLLocationCoordinate2D(latitude: 33.464434886242586,longitude: -112.49271007761436),
        ]),
        Field(acreSize: 3, farm: Farm(name: "Clarkson Farm", location: "Buckeye, Arizona"), crops: [Crop(type: .spinach, datePlanted: Date.now, estimatedHarvestDate: Date.now)], placemarkCoor: CLLocationCoordinate2D(latitude: 33.46107401968415, longitude: -112.51855992962584), fieldBoundary: [
            CLLocationCoordinate2D(latitude: 33.464434886242586, longitude: -112.49251424858844),
            CLLocationCoordinate2D(latitude: 33.46280120976414, longitude: -112.49251424858844),
            CLLocationCoordinate2D(latitude: 33.46280120976414, longitude: -112.4880591382487),
            CLLocationCoordinate2D(latitude: 33.464434886242586, longitude: -112.4880591382487),
        ]),
        Field(acreSize: 5, farm: Farm(name: "Clarkson Farm", location: "Buckeye, Arizona"), crops: [Crop(type: .romaine, datePlanted: Date.now, estimatedHarvestDate: Date.now)], placemarkCoor: CLLocationCoordinate2D(latitude: 33.46107401968415, longitude: -112.51855992962584), fieldBoundary: [
            CLLocationCoordinate2D(latitude: 33.459181058874705, longitude: -112.51317089597937),
            CLLocationCoordinate2D(latitude: 33.46449757496045, longitude: -112.51305572517622),
            CLLocationCoordinate2D(latitude: 33.464177312136414, longitude: -112.53870042400993),
            CLLocationCoordinate2D(latitude: 33.45110957997831, longitude: -112.53831652133279),
        ]),
        Field(acreSize: 15, farm: Farm(name: "Clarkson Farm", location: "Buckeye, Arizona"), crops: [Crop(type: .strawberries, datePlanted: Date.now, estimatedHarvestDate: Date.now)], placemarkCoor: CLLocationCoordinate2D(latitude: 33.46107401968415, longitude: -112.51855992962584), fieldBoundary: [
            CLLocationCoordinate2D(latitude: 33.45618706596004, longitude: -112.51958439974844),
            CLLocationCoordinate2D(latitude: 33.451903101851414, longitude: -112.53263038190252),
            CLLocationCoordinate2D(latitude: 33.450463328484034, longitude: -112.53263038190252),
            CLLocationCoordinate2D(latitude: 33.450518011119854, longitude: -112.51963177373725),
        ]),
        Field(acreSize: 15, farm: Farm(name: "Clarkson Farm", location: "Buckeye, Arizona"), crops: [Crop(type: .kale, datePlanted: Date.now, estimatedHarvestDate: Date.now)], placemarkCoor: CLLocationCoordinate2D(latitude: 33.46107401968415, longitude: -112.51855992962584), fieldBoundary: [
            CLLocationCoordinate2D(latitude: 33.45827070868714, longitude: -112.51320974565219),
            CLLocationCoordinate2D(latitude: 33.45620940057438, longitude: -112.51953564142381),
            CLLocationCoordinate2D(latitude: 33.45050627747874, longitude: -112.51962678185845),
            CLLocationCoordinate2D(latitude: 33.45054429954128, longitude: -112.51324695143425),
        ])
    ]
}


