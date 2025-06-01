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
    @Published var recenterUserLocation: Bool = false
    @Published var selectedField: String? = nil
    @Published var dynamicOffset: CGFloat = 200
    @Published var searchDynamicOffset: CGFloat = 700
    @Published var searchText: String = ""
    @Published var searchResults: [Field] = []
    @Published var selectedPolygonTitle: String?
    @Published var distanceThreshold: CLLocationDistance = 5000
    @Published var searchActive: Bool = false
    
    @Published var sampleFields = SampleFields.data
    
    // MARK: - Init
    
    init() {
        fieldSearch()
    }

    func fieldSearch() {
        
        searchActive.toggle()
        
        let currentLocation = userLocation ?? CLLocation(latitude: 0, longitude: 0)

        if searchText.isEmpty {
            searchResults = sampleFields.filter {
                $0.distance(to: currentLocation) <= distanceThreshold
            }
        } else {
            searchResults = sampleFields.filter {
                $0.farm.name.localizedCaseInsensitiveContains(searchText) ||
                $0.crops.first?.type.label.localizedCaseInsensitiveContains(searchText) ?? false
            }.filter {
                $0.distance(to: currentLocation) <= distanceThreshold
            }
        }

        // Reset selection and view state
        withAnimation {
            selectedPolygonTitle = nil
            selectedField = nil
            dynamicOffset = 200
            if searchDynamicOffset != 0 {
                searchDynamicOffset = 700
            }
        }

    }
    
    
    func getSelectedField() -> Crop {
        return sampleFields.first(where: {$0.id.description == selectedField})?.crops.first ?? Crop(type: .corn, datePlanted: Date(), estimatedHarvestDate: Date())
    }
    
    
}
