//
//  DrivingDirectionsButtonView.swift
//  CropCurious
//
//  Created by Vince Muller on 6/1/25.
//

import SwiftUI
import MapKit


struct DrivingDirectionsButtonView: View {
    
    var field: Field
    
    var body: some View {
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

#Preview {
    DrivingDirectionsButtonView(field: Field(acreSize: 0.0, farm: Farm(name: "Vince Farm", location: "Buckeye, AZ"), crops: [], placemarkCoor: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), fieldBoundary: []))
}
