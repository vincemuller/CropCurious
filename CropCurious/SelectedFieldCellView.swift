//
//  SelectedCropCellView.swift
//  CropCurious
//
//  Created by Vince Muller on 5/25/25.
//

import SwiftUI
import MapKit


struct SelectedFieldCellView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @Namespace var namespace2
    
    var body: some View {
        let crop = viewModel.getSelectedField()
        let farm = viewModel.sampleFields.first(where: {$0.id.description == viewModel.selectedField})?.farm.name ?? ""
        
        NavigationLink {
            
            FieldDetailsScreen(field: viewModel.sampleFields.first(where: {$0.id.description == viewModel.selectedField}) ?? Field(acreSize: 0.0, farm: Farm(name: "", location: ""), crops: [], placemarkCoor: CLLocationCoordinate2D(), fieldBoundary: []))
                .navigationBarBackButtonHidden(true)
                .navigationTransition(.zoom(sourceID: viewModel.selectedField, in: namespace2))
            
        } label: {
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(UIColor.systemBackground))
                HStack {
                    crop.type.thumbnail
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100)
                        .mask {
                            UnevenRoundedRectangle(topLeadingRadius: 20, bottomLeadingRadius: 20)
                        }
                    VStack (alignment: .leading) {
                        CCTextView(text: crop.type.label, size: 20, weight: .semibold)
                            .padding(.top)
                        CCTextView(text: farm, size: 14)
                            .padding(.bottom)
                        CCTextView(text: "Planted: \(crop.datePlanted.formatted(.dateTime.month().day().year()))", size: 12)
                        CCTextView(text: "Harvest: \(crop.estimatedHarvestDate.formatted(.dateTime.month().day().year()))", size: 12)
                            .padding(.bottom)
                    }
                    Spacer()
                }
            }
        }
        .frame(height: 100)
        .padding()
    }
}

#Preview {
    SelectedFieldCellView()
        .environmentObject(ViewModel())
}
