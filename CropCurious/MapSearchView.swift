//
//  AIViewForReference.swift
//  CropCurious
//
//  Created by Vince Muller on 5/18/25.
//

import SwiftUI
import MapKit

struct SampleFields {
    static let data: [Field] = [
        Field(acreSize: 10, farm: Farm(name: "Clarkson Farm", location: "Buckeye, Arizona"), crops: [Crop(name: "Corn", datePlanted: Date.now, estimatedHarvestDate: Date.now)], fieldBoundary: [
            CLLocationCoordinate2D(latitude: 33.457469, longitude: -112.514054),
            CLLocationCoordinate2D(latitude: 33.451068, longitude: -112.514352),
            CLLocationCoordinate2D(latitude: 33.450843, longitude: -112.524450),
            CLLocationCoordinate2D(latitude: 33.453947, longitude: -112.526418),
        ])
    ]
}

struct MapSearchView: View {
    @State private var dragOffset: CGFloat = 0
    @State private var pastSheetHeight: CGFloat = 60
    @State private var dynamicHeight: CGFloat = 60
    @State private var searchText: String = ""
    @FocusState private var isFocused: Bool
    @State private var selectedField: Field? = nil
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                MapViewContainer(selectedField: $selectedField, cropFields: SampleFields.data)
                    .edgesIgnoringSafeArea(.all)
            }
            .overlay(alignment: .bottom) {
                UnevenRoundedRectangle(topLeadingRadius: 20, topTrailingRadius: 20)
                    .fill(Color(UIColor.systemBackground))
                    .ignoresSafeArea()
                    .frame(height: dynamicHeight)
                    .shadow(radius: 5, x: 0, y: -5)
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                dragOffset = -(value.translation.height/1) + dynamicHeight
                                if dragOffset < 0 {
                                    dynamicHeight = 0
                                } else {
                                    dynamicHeight = dragOffset
                                }
                            })
                            .onEnded({ value in
                                if pastSheetHeight < (dragOffset - 100) && dragOffset < (geo.size.height / 2) {
                                    withAnimation (.default.speed(2.5)) {
                                        dynamicHeight = geo.size.height / 2
                                        pastSheetHeight = geo.size.height / 2
                                        dragOffset = 0
                                    }
                                } else if pastSheetHeight < (dragOffset - 100) && dragOffset > (geo.size.height / 2) {
                                    withAnimation (.default.speed(2.5)) {
                                        dynamicHeight = geo.size.height
                                        pastSheetHeight = geo.size.height
                                        dragOffset = 0
                                    }
                                } else if pastSheetHeight > (dragOffset - 100) && dragOffset > (geo.size.height / 2) {
                                    withAnimation (.default.speed(2.5)) {
                                        dynamicHeight = geo.size.height / 2
                                        pastSheetHeight = geo.size.height / 2
                                        dragOffset = 0
                                    }
                                }
                                else {
                                    withAnimation (.default.speed(2.5)) {
                                        dynamicHeight = 60
                                        pastSheetHeight = 60
                                        dragOffset = 0
                                    }
                                }
                            })
                    )
            }
            .overlay(alignment: .top) {
                ZStack {
                    RoundedRectangle(cornerRadius: 50)
                        .fill(dynamicHeight == geo.size.height ? Color(UIColor.secondarySystemBackground) : Color(UIColor.systemBackground))
                        .frame(height: 50)
                        .shadow(color: .black.opacity(dynamicHeight == geo.size.height ? 0 : 0.15), radius: 2, x: 0, y: 3)
                    HStack {
                        Image(systemName:  isFocused ? "arrow.left" :  "magnifyingglass")
                            .foregroundStyle(Color(UIColor.secondaryLabel))
                        ZStack (alignment: .leading) {
                            searchText.count > 0 ? nil : SearchCarouselView()
                            TextField("", text: $searchText)
                                .foregroundColor(Color(UIColor.label))
                                .focused($isFocused)
                                .onSubmit {
                                }
                        }
                        Spacer()
                    }
                    .padding(.leading)
                }
                .padding(.horizontal, 30)
            }
        }
    }
}


#Preview {
    MapSearchView()
}
