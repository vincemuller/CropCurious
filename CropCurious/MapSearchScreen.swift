//
//  AIViewForReference.swift
//  CropCurious
//
//  Created by Vince Muller on 5/18/25.
//

import SwiftUI
import MapKit


struct MapSearchScreen: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @FocusState var focused: Bool
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ZStack(alignment: .bottom) {
                    MapViewContainer(cropFields: viewModel.searchResults)
                        .edgesIgnoringSafeArea(.all)
                }
                .ignoresSafeArea(.keyboard)
                .overlay(alignment: .bottomTrailing) {
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
                .overlay(alignment: .bottom, content: {
                    SelectedFieldCellView(field: viewModel.sampleFields.first(where: {$0.id.description == viewModel.selectedField}) ?? Field(acreSize: 0.0, farm: Farm(name: "", location: ""), crops: [], placemarkCoor: CLLocationCoordinate2D(latitude: 0, longitude: 0), fieldBoundary: []))
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
                .overlay(alignment: .top) {
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
                                    viewModel.searchText = ""
                                    viewModel.searchResults = viewModel.sampleFields
                                    viewModel.selectedField = nil
                                    viewModel.selectedPolygonTitle = nil
                                    viewModel.dynamicOffset = 200
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
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                hideKeyboard()
                            }
                        }
                    }
                }
                .overlay(alignment: .bottom, content: {
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
                })
            }
            .ignoresSafeArea(.keyboard)
        }
        .ignoresSafeArea(.keyboard)
    }
}


#Preview {
    let vm = ViewModel()
    vm.sampleFields = SampleFields.data
    
    return MapSearchScreen()
        .environmentObject(vm)
}
