//
//  CropHeaderView.swift
//  CropCurious
//
//  Created by Vince Muller on 6/1/25.
//

import SwiftUI
import MapKit

struct CropHeaderView: View {
    
    var field: Field
    @Binding var selectedCrop: Crop
    
    var body: some View {
        VStack {
            CCTextView(text: selectedCrop.type.label, size: 40, weight: .semibold)
                .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                .overlay(alignment: .trailing) {
                    selectedCrop.id != field.crops.first?.id ? nil :
                    CCTextView(text: "✅ Current", size: 12, color: Color(UIColor.systemGreen))
                        .offset(x: -40)
                }
            CCTextView(text: field.farm.name, size: 20)
                .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                .padding(.bottom)
            HStack (spacing: 0) {
                CCTextView(text: "Planted: ", size: 14, weight: .semibold, color: Color(UIColor.label).opacity(0.8))
                CCTextView(text: selectedCrop.datePlanted.formatted(.dateTime.month().day().year()), size: 14, color: Color(UIColor.label).opacity(0.8))
                    .padding(.trailing, 20)
                CCTextView(text: "Harvest: ", size: 14, weight: .semibold, color: Color(UIColor.label).opacity(0.8))
                CCTextView(text: selectedCrop.estimatedHarvestDate.formatted(.dateTime.month().day().year()), size: 14, color: Color(UIColor.label).opacity(0.8))
                Spacer()
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
        .padding(.leading, 40)
        .padding(.vertical)
        Rectangle()
            .fill(Color(UIColor.label).opacity(0.3))
            .frame(height: 1)
            .padding()
    }
}

#Preview {
    CropHeaderView(field: Field(acreSize: 0.0, farm: Farm(name: "Vince Farm", location: "Buckeye, AZ"), crops: [], placemarkCoor: CLLocationCoordinate2D(latitude: 0, longitude: 0), fieldBoundary: []), selectedCrop: .constant(Crop(type: .corn, datePlanted: Date(), estimatedHarvestDate: Date())))
}
