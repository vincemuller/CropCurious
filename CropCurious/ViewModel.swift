//
//  ViewModel.swift
//  CropCurious
//
//  Created by Vince Muller on 5/24/25.
//

import Foundation
import SwiftUI

@MainActor
class ViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var selectedField: String? = nil
    @Published var dynamicOffset: CGFloat = 200
    @Published var searchDynamicOffset: CGFloat = 700
    @Published var searchText: String = ""
    @Published var searchResults: [Field] = []
    
    @Published var sampleFields = SampleFields.data
    
    // MARK: - Init
    
    init() {}
    
    func fieldSearch() {
        guard !searchText.isEmpty else {
            return searchResults = sampleFields
        }
        searchResults = sampleFields.filter({$0.farm.name.localizedCaseInsensitiveContains(searchText) || $0.crops.first?.type.label.localizedCaseInsensitiveContains(searchText) ?? false})
        
        if (searchResults.contains(where: {$0.id.description != selectedField})) {
            withAnimation {
                selectedField = nil
                dynamicOffset = 200
            }
        }
    }
    
    
}
