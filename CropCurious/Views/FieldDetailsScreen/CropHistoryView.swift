//
//  CropHistoryView.swift
//  CropCurious
//
//  Created by Vince Muller on 6/1/25.
//

import SwiftUI
import MapKit


struct CropHistoryView: View {
    
    var field: Field
    @Binding var selectedCrop: Crop
    
    var body: some View {
        CCTextView(text: "Crop History", size: 25, weight: .semibold)
            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
            .padding(.leading, 40)
            .padding(.bottom)
        ForEach(field.crops) { crop in
            HStack {
                Image(crop.type.label.lowercased())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .mask {
                        RoundedRectangle(cornerRadius: 15)
                    }
                VStack (alignment: .leading, spacing: 5) {
                    CCTextView(text: crop.type.label, size: 16, weight: .semibold, color: Color(crop.id != selectedCrop.id ? UIColor.label : UIColor.systemGreen))
                    HStack (spacing: 0) {
                        CCTextView(text: "Harvest: ", size: 14, weight: .semibold, color: Color(UIColor.label).opacity(0.8))
                        CCTextView(text: crop.estimatedHarvestDate.formatted(.dateTime.month().day().year()), size: 14, color: Color(UIColor.label).opacity(0.8))
                    }
                }
                Spacer()
            }
            .padding(.leading, 20)
            .overlay(alignment: .trailing, content: {
                crop.id != selectedCrop.id ? nil :
                Image(systemName: "checkmark")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(Color(UIColor.systemGreen))
                    .padding(.trailing)
            })
            .onTapGesture {
                selectedCrop = crop
            }
            Rectangle()
                .fill(Color(UIColor.label).opacity(0.5))
                .frame(height: 0.5)
                .padding(.leading, 100)
        }
        Color(UIColor.systemBackground)
            .frame(height: 500)
    }
}

#Preview {
    CropHistoryView(field: Field(acreSize: 0.0, farm: Farm(name: "Vince Farm", location: "Buckeye, AZ"), crops: [], placemarkCoor: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), fieldBoundary: []), selectedCrop: .constant(Crop(type: .corn, datePlanted: Date(), estimatedHarvestDate: Date())))
}
