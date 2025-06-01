//
//  CropImageView.swift
//  CropCurious
//
//  Created by Vince Muller on 6/1/25.
//

import SwiftUI

struct CropImageView: View {
    
    @Binding var selectedCrop: Crop
    
    var body: some View {
        VStack {
            Image(selectedCrop.type.label.lowercased())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 500)
                .mask (alignment: .top) {
                    Rectangle()
                }
            Spacer()
        }
    }
}

#Preview {
    CropImageView(selectedCrop: .constant(Crop(type: .corn, datePlanted: Date(), estimatedHarvestDate: Date())))
}
