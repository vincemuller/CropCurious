//
//  AIViewForReference.swift
//  CropCurious
//
//  Created by Vince Muller on 5/18/25.
//

import SwiftUI
import MapKit


struct MapSearchView: View {
    @State private var dragOffset: CGFloat = 0
    @State private var pastSheetHeight: CGFloat = 60
    @State private var dynamicHeight: CGFloat = 60

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                Map()
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
                                dynamicHeight = dragOffset
                            })
                            .onEnded({ value in
                                if pastSheetHeight < (dragOffset - 100) && dragOffset < (geo.size.height / 2) {
                                    withAnimation {
                                        dynamicHeight = geo.size.height / 2
                                        pastSheetHeight = geo.size.height / 2
                                        dragOffset = 0
                                    }
                                } else if pastSheetHeight < (dragOffset - 100) && dragOffset > (geo.size.height / 2) {
                                    withAnimation {
                                        dynamicHeight = geo.size.height
                                        pastSheetHeight = geo.size.height
                                        dragOffset = 0
                                    }
                                } else if pastSheetHeight > (dragOffset - 100) && dragOffset > (geo.size.height / 2) {
                                    withAnimation {
                                        dynamicHeight = geo.size.height / 2
                                        pastSheetHeight = geo.size.height / 2
                                        dragOffset = 0
                                    }
                                }
                                else {
                                    withAnimation {
                                        dynamicHeight = 60
                                        pastSheetHeight = 60
                                        dragOffset = 0
                                    }
                                }
                            })
                    )
            }
            .overlay(alignment: .top) {
                RoundedRectangle(cornerRadius: 50)
                    .fill(dynamicHeight == geo.size.height ? Color(UIColor.secondarySystemBackground) : Color(UIColor.systemBackground))
                    .frame(height: 50)
                    .shadow(color: .black.opacity(dynamicHeight == geo.size.height ? 0 : 0.15), radius: 2, x: 0, y: 3)
                    .padding(.horizontal, 30)
            }
        }
    }
}


#Preview {
    MapSearchView()
}
