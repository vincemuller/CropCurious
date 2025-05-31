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
            VStack {
                Image(selectedCrop.type.label.lowercased())
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
                        CCTextView(text: selectedCrop.type.label, size: 40, weight: .semibold)
                            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                            .overlay(alignment: .trailing) {
                                selectedCrop.id != field.crops.first?.id ? nil :
                                CCTextView(text: "✅ Current", size: 12, color: Color(UIColor.systemGreen))
                                    .offset(x: -40)
                            }
                        CCTextView(text: field.farm.name, size: 20)
                            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                            .padding(.bottom)
                        HStack (spacing: 0) {
                            CCTextView(text: "Planted: ", size: 14, weight: .semibold, color: Color(UIColor.label).opacity(0.8))
                            CCTextView(text: selectedCrop.datePlanted.formatted(.dateTime.month().day().year()), size: 14, color: Color(UIColor.label).opacity(0.8))
                                .padding(.trailing, 20)
                            CCTextView(text: "Harvested: ", size: 14, weight: .semibold, color: Color(UIColor.label).opacity(0.8))
                            CCTextView(text: selectedCrop.estimatedHarvestDate.formatted(.dateTime.month().day().year()), size: 14, color: Color(UIColor.label).opacity(0.8))
                            Spacer()
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                    .padding(.leading, 40)
                    .padding(.vertical)
                    Rectangle()
                        .fill(Color(UIColor.label).opacity(0.3))
                        .frame(height: 1)
                        .padding()
                    CCTextView(text: "Crop History", size: 25, weight: .semibold)
                        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                        .padding(.leading, 40)
                        .padding(.bottom)
                    ForEach(field.crops) { crop in
                        HStack {
                            Image(crop.type.label.lowercased())
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 70, height: 70)
                                .mask {
                                    RoundedRectangle(cornerRadius: 15)
                                }
                            VStack (alignment: .leading, spacing: 5) {
                                CCTextView(text: crop.type.label, size: 16, weight: .semibold, color: Color(crop.id != selectedCrop.id ? UIColor.label : UIColor.systemGreen))
                                HStack (spacing: 0) {
                                    CCTextView(text: "Harvest: ", size: 14, weight: .semibold, color: Color(UIColor.label).opacity(0.8))
                                    CCTextView(text: crop.estimatedHarvestDate.formatted(.dateTime.month().day().year()), size: 14, color: Color(UIColor.label).opacity(0.8))
                                }
                            }
                            Spacer()
                        }
                        .padding(.leading, 20)
                        .overlay(alignment: .trailing, content: {
                            crop.id != selectedCrop.id ? nil :
                            Image(systemName: "checkmark")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(Color(UIColor.systemGreen))
                                .padding(.trailing)
                        })
                        .onTapGesture {
                            selectedCrop = crop
                        }
                        Rectangle()
                            .fill(Color(UIColor.label).opacity(0.5))
                            .frame(height: 0.5)
                            .padding(.leading, 100)
                    }
                    Color(UIColor.systemBackground)
                        .frame(height: 500)
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
                Button {
                    let latitude = field.placemarkCoor.latitude.description
                    let longitude = field.placemarkCoor.longitude.description
                    let url = URL(string: "maps://?q=\(latitude),\(longitude)")
                    
                    
                    if UIApplication.shared.canOpenURL(url!) {
                          UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                    }
                    
                } label: {
                        ZStack {
                            Circle()
                                .fill(Color(UIColor.systemBackground))
                                .shadow(radius: 5)
                            Image(systemName: "car.fill")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(Color(UIColor.label).opacity(0.8))
                                
                        }
                        .frame(width: 30, height: 30)
                }
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
