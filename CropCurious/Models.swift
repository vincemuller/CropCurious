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
        Field(acreSize: 7, farm: Farm(name: "Stevenson Farm", location: "Buckeye, Arizona"), crops: [Crop(type: .potatoes, datePlanted: Date.now, estimatedHarvestDate: Date.now)], placemarkCoor: CLLocationCoordinate2D(latitude: 33.4638122338031, longitude: -112.4940740589009), fieldBoundary: [
            CLLocationCoordinate2D(latitude: 33.464434886242586,longitude: -112.49530481220827),
            CLLocationCoordinate2D(latitude: 33.46280120976414,longitude: -112.49530481220827),
            CLLocationCoordinate2D(latitude: 33.46280120976414,longitude: -112.49271007761436),
            CLLocationCoordinate2D(latitude: 33.464434886242586,longitude: -112.49271007761436),
        ]),
        Field(acreSize: 3, farm: Farm(name: "Stevenson Farm", location: "Buckeye, Arizona"), crops: [Crop(type: .spinach, datePlanted: Date.now, estimatedHarvestDate: Date.now)], placemarkCoor: CLLocationCoordinate2D(latitude: 33.46397369919232, longitude: -112.49078379754307), fieldBoundary: [
            CLLocationCoordinate2D(latitude: 33.464434886242586, longitude: -112.49251424858844),
            CLLocationCoordinate2D(latitude: 33.46280120976414, longitude: -112.49251424858844),
            CLLocationCoordinate2D(latitude: 33.46280120976414, longitude: -112.4880591382487),
            CLLocationCoordinate2D(latitude: 33.464434886242586, longitude: -112.4880591382487),
        ]),
        Field(acreSize: 5, farm: Farm(name: "Clarkson Farm", location: "Buckeye, Arizona"), crops: [Crop(type: .corn, datePlanted: Date.now, estimatedHarvestDate: Date.now)], placemarkCoor: CLLocationCoordinate2D(latitude: 33.46000139077907, longitude: -112.52685179060758), fieldBoundary: [
            CLLocationCoordinate2D(latitude: 33.459181058874705, longitude: -112.51317089597937),
            CLLocationCoordinate2D(latitude: 33.46449757496045, longitude: -112.51305572517622),
            CLLocationCoordinate2D(latitude: 33.464177312136414, longitude: -112.53870042400993),
            CLLocationCoordinate2D(latitude: 33.45110957997831, longitude: -112.53831652133279),
        ]),
        Field(acreSize: 15, farm: Farm(name: "Clarkson Farm", location: "Buckeye, Arizona"), crops: [Crop(type: .strawberries, datePlanted: Date.now, estimatedHarvestDate: Date.now)], placemarkCoor: CLLocationCoordinate2D(latitude: 33.45267054767926, longitude: -112.52551525844672), fieldBoundary: [
            CLLocationCoordinate2D(latitude: 33.45618706596004, longitude: -112.51958439974844),
            CLLocationCoordinate2D(latitude: 33.451903101851414, longitude: -112.53263038190252),
            CLLocationCoordinate2D(latitude: 33.450463328484034, longitude: -112.53263038190252),
            CLLocationCoordinate2D(latitude: 33.450518011119854, longitude: -112.51963177373725),
        ]),
        Field(acreSize: 15, farm: Farm(name: "Clarkson Farm", location: "Buckeye, Arizona"), crops: [Crop(type: .wheat, datePlanted: Date.now, estimatedHarvestDate: Date.now)], placemarkCoor: CLLocationCoordinate2D(latitude: 33.453962135626256, longitude: -112.51593506099982), fieldBoundary: [
            CLLocationCoordinate2D(latitude: 33.45827070868714, longitude: -112.51320974565219),
            CLLocationCoordinate2D(latitude: 33.45620940057438, longitude: -112.51953564142381),
            CLLocationCoordinate2D(latitude: 33.45050627747874, longitude: -112.51962678185845),
            CLLocationCoordinate2D(latitude: 33.45054429954128, longitude: -112.51324695143425),
        ]),
        Field(
            acreSize: 6,
            farm: Farm(name: "Stevenson Farm", location: "Buckeye, Arizona"),
            crops: [Crop(type: .corn, datePlanted: Date(), estimatedHarvestDate: Date())],
            placemarkCoor: CLLocationCoordinate2D(latitude: 33.4655, longitude: -112.4960),
            fieldBoundary: [
                CLLocationCoordinate2D(latitude: 33.4660, longitude: -112.4965),
                CLLocationCoordinate2D(latitude: 33.4650, longitude: -112.4965),
                CLLocationCoordinate2D(latitude: 33.4650, longitude: -112.4955),
                CLLocationCoordinate2D(latitude: 33.4660, longitude: -112.4955),
            ]
        ),
        Field(
            acreSize: 4,
            farm: Farm(name: "Clarkson Farm", location: "Buckeye, Arizona"),
            crops: [Crop(type: .beets, datePlanted: Date(), estimatedHarvestDate: Date())],
            placemarkCoor: CLLocationCoordinate2D(latitude: 33.45990509747867, longitude: -112.48726331869116),
            fieldBoundary: [
                CLLocationCoordinate2D(latitude: 33.46186550792784, longitude: -112.49094138022245),
                CLLocationCoordinate2D(latitude: 33.45751845101121, longitude: -112.49094138022245),
                CLLocationCoordinate2D(latitude: 33.45751845101121, longitude: -112.4833298362202),
                CLLocationCoordinate2D(latitude: 33.46186550792784, longitude: -112.4833298362202),
            ]
        ),
        Field(
            acreSize: 5,
            farm: Farm(name: "Stevenson Farm", location: "Buckeye, Arizona"),
            crops: [Crop(type: .kale, datePlanted: Date(), estimatedHarvestDate: Date())],
            placemarkCoor: CLLocationCoordinate2D(latitude: 33.4590, longitude: -112.4930),
            fieldBoundary: [
                CLLocationCoordinate2D(latitude: 33.4595, longitude: -112.4935),
                CLLocationCoordinate2D(latitude: 33.4585, longitude: -112.4935),
                CLLocationCoordinate2D(latitude: 33.4585, longitude: -112.4925),
                CLLocationCoordinate2D(latitude: 33.4595, longitude: -112.4925),
            ]
        ),
        Field(
            acreSize: 7,
            farm: Farm(name: "Clarkson Farm", location: "Buckeye, Arizona"),
            crops: [Crop(type: .romaine, datePlanted: Date(), estimatedHarvestDate: Date())],
            placemarkCoor: CLLocationCoordinate2D(latitude: 33.456796827108576, longitude: -112.49360475261413),
            fieldBoundary: [
                CLLocationCoordinate2D(latitude: 33.46186841453206, longitude: -112.49539269919184),
                CLLocationCoordinate2D(latitude: 33.45061676079412, longitude: -112.49539269919184),
                CLLocationCoordinate2D(latitude: 33.45061676079412, longitude: -112.49161246928469),
                CLLocationCoordinate2D(latitude: 33.46186841453206, longitude: -112.49161246928469),
            ]
        ),
        Field(
            acreSize: 3,
            farm: Farm(name: "Stevenson Farm", location: "Buckeye, Arizona"),
            crops: [Crop(type: .spinach, datePlanted: Date(), estimatedHarvestDate: Date())],
            placemarkCoor: CLLocationCoordinate2D(latitude: 33.46356149624937, longitude: -112.48616316675083),
            fieldBoundary: [
                CLLocationCoordinate2D(latitude: 33.46429254022533, longitude: -112.48729314098773),
                CLLocationCoordinate2D(latitude: 33.462830446108114, longitude: -112.48729314098773),
                CLLocationCoordinate2D(latitude: 33.462830446108114, longitude: -112.48487176762339),
                CLLocationCoordinate2D(latitude: 33.46429254022533, longitude: -112.48487176762339),
            ]
        )
    ]
}

