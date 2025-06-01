//
//  ResetUserLocationButtonView.swift
//  CropCurious
//
//  Created by Vince Muller on 6/1/25.
//

import SwiftUI

struct ResetUserLocationButtonView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        if viewModel.searchDynamicOffset != 0 {
            Button {
                viewModel.recenterUserLocation.toggle()
            } label: {
                Image(systemName: "location")
                    .font(.system(size: 20))
                    .foregroundColor(Color(UIColor.label))
                    .padding(10)
                    .background(Color(UIColor.systemBackground))
                    .clipShape(Circle())
                    .shadow(radius: 4)
            }
            .padding(.trailing, 20)
            .padding(.bottom, 140)
        }
    }
}

#Preview {
    ResetUserLocationButtonView()
}
