//
//  SearchResultsListView.swift
//  CropCurious
//
//  Created by Vince Muller on 6/1/25.
//

import SwiftUI

struct SearchResultsListView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        ZStack (alignment: .top) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(UIColor.systemBackground))
                .shadow(radius: 5)
            VStack  {
                Button {
                    withAnimation {
                        viewModel.searchDynamicOffset = 0
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 70, height: 5)
                        .foregroundStyle(Color(UIColor.label).opacity(0.5))
                }
                .padding(.top)
                viewModel.searchDynamicOffset == 0 ? nil :
                CCTextView(text: "\(viewModel.searchResults.count) fields", size: 16, weight: .semibold)
                    .padding()
                ScrollView {
                    VStack {
                        ForEach(viewModel.searchResults, id: \.id) { result in
                            SearchResultCellView(field: result)
                        }
                    }
                }
                .frame(height: 700)
                .offset(y: 100)
            }
        }
        .ignoresSafeArea()
        .ignoresSafeArea(.keyboard)
        .offset(y: viewModel.searchDynamicOffset)
    }
}

#Preview {
    SearchResultsListView()
}
