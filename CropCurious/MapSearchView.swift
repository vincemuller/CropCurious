//
//  AIViewForReference.swift
//  CropCurious
//
//  Created by Vince Muller on 5/18/25.
//

import SwiftUI
import MapKit


struct MapSearchView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @FocusState var focused: Bool
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                MapViewContainer(cropFields: viewModel.searchResults)
                    .edgesIgnoringSafeArea(.all)
            }
            .overlay(alignment: .bottom, content: {
                SelectedFieldCellView()
                    .offset(y: viewModel.dynamicOffset)
            })
            .overlay(alignment: .bottom) {
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
                            Image(systemName: "chevron.up")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(Color(UIColor.label).opacity(0.5))
                        }
                        .padding(.top)

                        Text("\(viewModel.searchResults.count) fields")
                            .font(.system(size: 16, weight: .semibold))
                            .padding()
                    }
                }
                .ignoresSafeArea()
                .offset(y: viewModel.searchDynamicOffset)
            }
            .overlay(alignment: .top) {
                ZStack {
                    RoundedRectangle(cornerRadius: 50)
                        .fill(viewModel.searchDynamicOffset == 0 ? Color(UIColor.secondarySystemBackground) : Color(UIColor.systemBackground))
                        .frame(height: 50)
                        .shadow(color: .black.opacity(viewModel.searchDynamicOffset != 0 ? 0.15 : 0.0), radius: 2, x: 0, y: 3)
                    ZStack {
                        HStack {
                            Button {
                                withAnimation {
                                    focused = false
                                    viewModel.searchText = ""
                                    viewModel.searchResults = viewModel.sampleFields
                                    if (viewModel.dynamicOffset == 0) {
                                        viewModel.searchDynamicOffset = 900
                                    } else {
                                        viewModel.searchDynamicOffset = 700
                                    }
                                }
                            } label: {
                                Image(systemName: focused || !viewModel.searchText.isEmpty ? "arrow.left" : "magnifyingglass")
                                    .foregroundStyle(Color(UIColor.secondaryLabel))
                            }
                            .disabled(focused || !viewModel.searchText.isEmpty ? false : true)
                            !viewModel.searchText.isEmpty ? nil :
                            SearchCarouselView()
                            Spacer()
                        }
                        TextField("", text: $viewModel.searchText)
                            .offset(x: 28)
                            .focused($focused)
                            .onSubmit {
                                viewModel.fieldSearch()
                                withAnimation {
                                    viewModel.dynamicOffset = 200
                                    viewModel.searchDynamicOffset = 700
                                }
                            }
                    }
                    .padding()
                }
                .padding(.horizontal, 30)
            }
            .onAppear(perform: {
                viewModel.searchResults = viewModel.sampleFields
            })
        }
    }
}


#Preview {
    let vm = ViewModel()
    vm.sampleFields = [/* mock fields here if needed */]

    return MapSearchView()
        .environmentObject(vm)}
