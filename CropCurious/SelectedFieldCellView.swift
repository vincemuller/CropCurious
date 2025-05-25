//
//  SelectedCropCellView.swift
//  CropCurious
//
//  Created by Vince Muller on 5/25/25.
//

import SwiftUI

struct SelectedFieldCellView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        let crop = viewModel.sampleFields.first(where: {$0.id.description == viewModel.selectedField})?.crops.first?.type.label ?? ""
        let farm = viewModel.sampleFields.first(where: {$0.id.description == viewModel.selectedField})?.farm.name ?? ""
        let plantedDate = viewModel.sampleFields.first(where: {$0.id.description == viewModel.selectedField})?.crops.first?.datePlanted ?? Date.now
        let harvestDate = viewModel.sampleFields.first(where: {$0.id.description == viewModel.selectedField})?.crops.first?.estimatedHarvestDate ?? Date.now
        ZStack {
            RoundedRectangle(cornerRadius: 20)
            HStack {
                UnevenRoundedRectangle(topLeadingRadius: 20, bottomLeadingRadius: 20)
                    .fill(.red)
                    .frame(width: 100)
                VStack (alignment: .leading) {
                    Text(crop)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(Color.white)
                    Text(farm)
                        .font(.system(size: 14))
                        .foregroundStyle(Color.white)
                        .padding(.bottom)
                    Text("Planted: \(plantedDate.formatted(.dateTime.month().day().year()))")
                        .font(.system(size: 14))
                        .foregroundStyle(Color.white)
                    Text("Harvest Date: \(harvestDate.formatted(.dateTime.month().day().year()))")
                        .font(.system(size: 14))
                        .foregroundStyle(Color.white)
                }
                Spacer()
            }
        }
        .frame(height: 150)
        .padding()
    }
}

#Preview {
    SelectedFieldCellView()
}
