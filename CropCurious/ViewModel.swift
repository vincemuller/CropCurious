//
//  ViewModel.swift
//  CropCurious
//
//  Created by Vince Muller on 5/24/25.
//

import Foundation

@MainActor
class ViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var selectedField: String? = nil
    @Published var dynamicOffset: CGFloat = 200
    
    var sampleFields = SampleFields.data
    
    // MARK: - Init
    
    init() {}
    
    
}
