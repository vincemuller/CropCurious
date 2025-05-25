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
    
    @Published var cropDetailSheetPresenting: Bool = false
    @Published var selectedField: String? = nil
    var sampleFields = SampleFields.data
    
    
    // MARK: - Init
    
    init() {}
    
    
}
