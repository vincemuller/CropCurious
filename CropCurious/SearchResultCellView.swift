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
    
    var body: some View {
        
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
                VStack (alignment: .leading) {
                    Text(field.crops.first?.type.label ?? "")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(Color(UIColor.label))
                        .padding(.top)
                    Text(field.farm.name)
                        .font(.system(size: 14))
                        .foregroundStyle(Color(UIColor.label))
                        .padding(.bottom)
                    Text("Planted: \(field.crops.first?.datePlanted.formatted(.dateTime.month().day().year()) ?? "")")
                        .font(.system(size: 12))
                        .foregroundStyle(Color(UIColor.label))
                    Text("Harvest Date: \(field.crops.first?.estimatedHarvestDate.formatted(.dateTime.month().day().year()) ?? "")")
                        .font(.system(size: 12))
                        .foregroundStyle(Color(UIColor.label))
                        .padding(.bottom)
                }
                Spacer()
            }
        }
        .frame(height: 100)
        .padding()
    }
}

#Preview {
    SearchResultCellView(field: Field(acreSize: 0.5, farm: Farm(name: "Vince's Farm", location: "Buckeye, AZ"), crops: [Crop(type: .beets, datePlanted: Date.now, estimatedHarvestDate: Date.now)], placemarkCoor: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), fieldBoundary: []))
}
