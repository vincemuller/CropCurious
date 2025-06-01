//
//  SearchBarView.swift
//  CropCurious
//
//  Created by Vince Muller on 6/1/25.
//

import SwiftUI

struct SearchBarView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @FocusState var focused: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .fill(viewModel.searchDynamicOffset == 0 ? Color(UIColor.secondarySystemBackground) : Color(UIColor.systemBackground))
                .frame(height: 50)
                .shadow(color: .black.opacity(viewModel.searchDynamicOffset != 0 ? 0.15 : 0.0), radius: 2, x: 0, y: 3)
            ZStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(Color(UIColor.secondaryLabel))
                    !viewModel.searchText.isEmpty ? nil :
                    SearchCarouselView()
                    Spacer()
                }
                HStack {
                    TextField("", text: $viewModel.searchText)
                        .offset(x: 28)
                        .focused($focused)
                        .onSubmit {
                            viewModel.fieldSearch()
                        }
                    !focused && viewModel.searchText.isEmpty ? nil :
                    Button {
                        viewModel.clearSearch()
                        focused = false
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(Color.red)
                    }

                }
            }
            .padding()
        }
        .padding(.horizontal, 30)
    }
}

#Preview {
    SearchBarView()
}
