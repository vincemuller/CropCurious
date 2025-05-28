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
        let thumbnail = viewModel.sampleFields.first(where: {$0.id.description == viewModel.selectedField})?.crops.first?.type.thumbnail ?? Image("corn")
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(UIColor.systemBackground))
            HStack {
                thumbnail
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .mask {
                        UnevenRoundedRectangle(topLeadingRadius: 20, bottomLeadingRadius: 20)
                    }
                VStack (alignment: .leading) {
                    Text(crop)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(Color(UIColor.label))
                        .padding(.top)
                    Text(farm)
                        .font(.system(size: 14))
                        .foregroundStyle(Color(UIColor.label))
                        .padding(.bottom)
                    Text("Planted: \(plantedDate.formatted(.dateTime.month().day().year()))")
                        .font(.system(size: 12))
                        .foregroundStyle(Color(UIColor.label))
                    Text("Harvest Date: \(harvestDate.formatted(.dateTime.month().day().year()))")
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
    SelectedFieldCellView()
        .environmentObject(ViewModel())
}
