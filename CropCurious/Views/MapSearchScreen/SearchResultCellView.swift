//
//  SearchResultCellView.swift
//  CropCurious
//
//  Created by Vince Muller on 5/28/25.
//

import SwiftUI
import MapKit


struct SearchResultCellView: View {
    
    var field: Field
    @Namespace var namespace
    
    var body: some View {
        NavigationLink {
            
            FieldDetailsScreen(field: field)
                .navigationBarBackButtonHidden(true)
                .navigationTransition(.zoom(sourceID: field.id, in: namespace))
            
        } label: {
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(UIColor.secondarySystemBackground))
                HStack {
                    Image(field.crops.first?.type.label.lowercased() ?? "")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100)
                        .mask {
                            UnevenRoundedRectangle(topLeadingRadius: 20, bottomLeadingRadius: 20)
                        }
                        .matchedTransitionSource(id: field.id, in: namespace)
                    VStack (alignment: .leading) {
                        CCTextView(text: field.crops.first?.type.label ?? "", size: 18, weight: .semibold)
                            .padding(.top, 5)
                        CCTextView(text: field.farm.name, size: 12)
                        CCTextView(text: field.farm.location, size: 10)
                            .padding(.bottom)
                        CCTextView(text: "Harvest: \(field.crops.first?.estimatedHarvestDate.formatted(.dateTime.month().day().year()) ?? "")", size: 10)
                            .padding(.bottom, 10)
                    }
                    Spacer()
                }
            }
            .frame(height: 80)
            .padding()
        }
    }
}

#Preview {
    SearchResultCellView(field: Field(acreSize: 0.5, farm: Farm(name: "Vince's Farm", location: "Buckeye, AZ"), crops: [Crop(type: .beets, datePlanted: Date.now, estimatedHarvestDate: Date.now)], placemarkCoor: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), fieldBoundary: []))
}
