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
                        Text(field.crops.first?.type.label ?? "")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(Color(UIColor.label))
                            .padding(.top, 5)
                        Text(field.farm.name)
                            .font(.system(size: 12))
                            .foregroundStyle(Color(UIColor.label))
                        Text(field.farm.location)
                            .font(.system(size: 10))
                            .foregroundStyle(Color(UIColor.label))
                            .padding(.bottom)
                        Text("Harvest Date: \(field.crops.first?.estimatedHarvestDate.formatted(.dateTime.month().day().year()) ?? "")")
                            .font(.system(size: 10))
                            .foregroundStyle(Color(UIColor.label))
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
