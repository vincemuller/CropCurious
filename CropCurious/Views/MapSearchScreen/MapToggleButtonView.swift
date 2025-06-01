//
//  MapToggleButtonView.swift
//  CropCurious
//
//  Created by Vince Muller on 6/1/25.
//

import SwiftUI

struct MapToggleButtonView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        viewModel.searchDynamicOffset != 0 ? nil :
        Button {
            withAnimation {
                viewModel.searchDynamicOffset = 700
            }
        } label: {
            HStack {
                Image(systemName: "map")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color(UIColor.black))
                CCTextView(text: "Map", size: 18, weight: .semibold, color: Color.black)
            }
            .padding(15)
            .background {
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color(UIColor.systemGreen))
            }
        }
    }
}

#Preview {
    MapToggleButtonView()
}
