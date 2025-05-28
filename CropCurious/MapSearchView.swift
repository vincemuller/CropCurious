//
//  AIViewForReference.swift
//  CropCurious
//
//  Created by Vince Muller on 5/18/25.
//

import SwiftUI
import MapKit


struct MapSearchView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                MapViewContainer(cropFields: viewModel.sampleFields)
                    .edgesIgnoringSafeArea(.all)
            }
            .overlay(alignment: .bottom, content: {
                SelectedFieldCellView()
                    .offset(y: viewModel.dynamicOffset)
            })
        }
    }
}


#Preview {
    MapSearchView()
        .environmentObject(ViewModel())
}
