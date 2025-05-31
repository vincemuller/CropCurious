//
//  ViewModel.swift
//  CropCurious
//
//  Created by Vince Muller on 5/24/25.
//

import Foundation
import SwiftUI
import MapKit

@MainActor
class ViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var userLocation: CLLocation? = nil
    @Published var selectedField: String? = nil
    @Published var dynamicOffset: CGFloat = 200
    @Published var searchDynamicOffset: CGFloat = 700
    @Published var searchText: String = ""
    @Published var searchResults: [Field] = []
    @Published var selectedPolygonTitle: String?
    @Published var distanceThreshold: CLLocationDistance = 5000
    
    @Published var sampleFields = SampleFields.data
    
    // MARK: - Init
    
    init() {}

    func fieldSearch() {
        guard !searchText.isEmpty else {
            
            return searchResults = sampleFields.filter({$0.distance(to: userLocation ?? CLLocation(latitude: CLLocationDegrees(0.0), longitude: CLLocationDegrees(0.0))) <= distanceThreshold})
            
        }
        
        searchResults = sampleFields.filter({$0.farm.name.localizedCaseInsensitiveContains(searchText) || $0.crops.first?.type.label.localizedCaseInsensitiveContains(searchText) ?? false})
        
        searchResults = searchResults.filter({$0.distance(to: userLocation ?? CLLocation(latitude: CLLocationDegrees(0.0), longitude: CLLocationDegrees(0.0))) <= distanceThreshold})
        
        if (searchResults.contains(where: {$0.id.description != selectedField})) {
            withAnimation {
                selectedField = nil
                dynamicOffset = 200
            }
        }
    }
    
    func getSelectedField() -> Crop {
        return sampleFields.first(where: {$0.id.description == selectedField})?.crops.first ?? Crop(type: .corn, datePlanted: Date(), estimatedHarvestDate: Date())
    }
    
    
}
