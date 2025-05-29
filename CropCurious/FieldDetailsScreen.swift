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
    
    var body: some View {
        ZStack (alignment: .top) {
            VStack {
                Image(field.crops.first?.type.label.lowercased() ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 500)
                    .mask (alignment: .top) {
                        Rectangle()
                    }
                Spacer()
            }
            ScrollView {
                VStack {
                    VStack {
                        Text(field.crops.first?.type.label ?? "")
                            .font(.system(size: 40, weight: .semibold))
                            .foregroundStyle(Color(UIColor.label))
                            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                        Text(field.farm.name)
                            .font(.system(size: 20))
                            .foregroundStyle(Color(UIColor.label))
                            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                        Text(field.farm.location)
                            .font(.system(size: 14))
                            .foregroundStyle(Color(UIColor.label))
                            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                        Text("\(field.acreSize.description) acres")
                            .font(.system(size: 14))
                            .foregroundStyle(Color(UIColor.label))
                            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                        Text("Planted: \(field.crops.first?.datePlanted.formatted(.dateTime.month().day().year()) ?? "")")
                            .font(.system(size: 14))
                            .foregroundStyle(Color(UIColor.label))
                            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                        Text("Harvest Date: \(field.crops.first?.estimatedHarvestDate.formatted(.dateTime.month().day().year()) ?? "")")
                            .font(.system(size: 14))
                            .foregroundStyle(Color(UIColor.label))
                            .padding(.bottom)
                            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                    }
                    .padding(.leading, 40)
                    .padding(.vertical)
                    Rectangle()
                        .fill(Color(UIColor.label).opacity(0.3))
                        .frame(height: 1)
                        .padding(.horizontal)
                    
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
    }
}

#Preview {
    FieldDetailsScreen(field: Field(acreSize: 6,
                                   farm: Farm(name: "Stevenson Farm", location: "Buckeye, Arizona"),
                                   crops: [Crop(type: .corn, datePlanted: Date(), estimatedHarvestDate: Date())],
                                   placemarkCoor: CLLocationCoordinate2D(latitude: 33.4655, longitude: -112.4960),
                                   fieldBoundary: [
                                    CLLocationCoordinate2D(latitude: 33.4660, longitude: -112.4965),
                                    CLLocationCoordinate2D(latitude: 33.4650, longitude: -112.4965),
                                    CLLocationCoordinate2D(latitude: 33.4650, longitude: -112.4955),
                                    CLLocationCoordinate2D(latitude: 33.4660, longitude: -112.4955),
        ]
    ))
}
