//
//  AIViewForReference.swift
//  CropCurious
//
//  Created by Vince Muller on 5/18/25.
//

import SwiftUI
import MapKit


struct MapSearchScreen: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ZStack(alignment: .bottom) {
                    MapViewContainer(cropFields: viewModel.searchResults)
                        .edgesIgnoringSafeArea(.all)
                }
                .ignoresSafeArea(.keyboard)
                .overlay(alignment: .bottomTrailing) {
                    ResetUserLocationButtonView()
                }
                .overlay(alignment: .bottom, content: {
                    SelectedFieldCellView(field: viewModel.sampleFields.first(where: {$0.id.description == viewModel.selectedField}) ?? Field(acreSize: 0.0, farm: Farm(name: "", location: ""), crops: [], placemarkCoor: CLLocationCoordinate2D(latitude: 0, longitude: 0), fieldBoundary: []))
                        .offset(y: viewModel.dynamicOffset)
                })
                .overlay(alignment: .bottom) {
                    SearchResultsListView()
                }
                .overlay(alignment: .top) {
                    SearchBarView()
                }
                .overlay(alignment: .bottom, content: {
                    MapToggleButtonView()
                })
            }
            .ignoresSafeArea(.keyboard)
        }
        .ignoresSafeArea(.keyboard)
    }
}


#Preview {
    let vm = ViewModel()
    vm.sampleFields = SampleFields.data
    
    return MapSearchScreen()
        .environmentObject(vm)
}
