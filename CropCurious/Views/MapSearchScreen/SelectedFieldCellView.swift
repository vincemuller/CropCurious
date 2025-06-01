//
//  SelectedCropCellView.swift
//  CropCurious
//
//  Created by Vince Muller on 5/25/25.
//

import SwiftUI
import MapKit


struct SelectedFieldCellView: View {
    
    var field: Field
    @Namespace var namespace2
    
    var body: some View {
        
        NavigationLink {
            
            FieldDetailsScreen(field: field)
                .navigationBarBackButtonHidden(true)
                .navigationTransition(.zoom(sourceID: field.id, in: namespace2))
            
        } label: {
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(UIColor.systemBackground))
                HStack {
                    Image(field.crops.first?.type.label.lowercased() ?? "")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100)
                        .mask {
                            UnevenRoundedRectangle(topLeadingRadius: 20, bottomLeadingRadius: 20)
                        }
                        .matchedTransitionSource(id: field.id, in: namespace2)
                    VStack (alignment: .leading) {
                        CCTextView(text: field.crops.first?.type.label ?? "", size: 20, weight: .semibold)
                            .padding(.top)
                        CCTextView(text: field.farm.name, size: 14)
                            .padding(.bottom)
                        CCTextView(text: "Planted: \(field.crops.first?.datePlanted.formatted(.dateTime.month().day().year()) ?? "")", size: 12)
                        CCTextView(text: "Harvest: \(field.crops.first?.estimatedHarvestDate.formatted(.dateTime.month().day().year()) ?? "")", size: 12)
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
    NavigationStack {
        SelectedFieldCellView(field: Field(acreSize: 0.0, farm: Farm(name: "Vince Farm", location: "Buckeye, AZ"), crops: [Crop(type: .corn, datePlanted: Date(), estimatedHarvestDate: Date())], placemarkCoor: CLLocationCoordinate2D(latitude: 0, longitude: 0), fieldBoundary: []))
            .environmentObject(ViewModel())
    }
}
