//
//  FieldDetailsScreen.swift
//  CropCurious
//
//  Created by Vince Muller on 5/29/25.
//

import SwiftUI
import MapKit

struct FieldDetailsScreen: View {
    var field: Field
    @State var selectedCrop: Crop = Crop(type: .corn, datePlanted: Date(), estimatedHarvestDate: Date())
    
    var body: some View {
        ZStack (alignment: .top) {
            CropImageView(selectedCrop: $selectedCrop)
            ScrollView {
                VStack {
                    CropHeaderView(field: field, selectedCrop: $selectedCrop)
                    CropHistoryView(field: field, selectedCrop: $selectedCrop)
                }
                .frame(width: UIScreen.main.bounds.width)
                .background {
                    UnevenRoundedRectangle(topLeadingRadius: 20, topTrailingRadius: 20)
                        .fill(Color(UIColor.systemBackground))
                }
                .offset(y: 400)
            }
        }
        .ignoresSafeArea()
        .onAppear(perform: {
            selectedCrop = field.crops.first ?? Crop(type: .corn, datePlanted: Date(), estimatedHarvestDate: Date())
        })
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                DrivingDirectionsButtonView(field: field)
            }
        }
    }
}

#Preview {
    FieldDetailsScreen(field: Field(acreSize: 6,
                                   farm: Farm(name: "Stevenson Farm", location: "Buckeye, Arizona"),
                                    crops: [Crop(type: .corn, datePlanted: Date(), estimatedHarvestDate: Date()),Crop(type: .strawberries, datePlanted: Date(), estimatedHarvestDate: Date()),Crop(type: .beets, datePlanted: Date(), estimatedHarvestDate: Date())],
                                   placemarkCoor: CLLocationCoordinate2D(latitude: 33.4655, longitude: -112.4960),
                                   fieldBoundary: [
                                    CLLocationCoordinate2D(latitude: 33.4660, longitude: -112.4965),
                                    CLLocationCoordinate2D(latitude: 33.4650, longitude: -112.4965),
                                    CLLocationCoordinate2D(latitude: 33.4650, longitude: -112.4955),
                                    CLLocationCoordinate2D(latitude: 33.4660, longitude: -112.4955),
        ]
                                   ))
}
