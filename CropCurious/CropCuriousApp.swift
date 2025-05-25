//
//  CropCuriousApp.swift
//  CropCurious
//
//  Created by Vince Muller on 5/17/25.
//

import SwiftUI

@main
struct CropCuriousApp: App {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            MapSearchView()
                .environmentObject(viewModel)
        }
    }
}
