//
//  CCTextView.swift
//  CropCurious
//
//  Created by Vince Muller on 5/31/25.
//

import SwiftUI

struct CCTextView: View {
    
    var text: String
    var size: CGFloat
    var weight: Font.Weight = .regular
    var color: Color = Color(UIColor.label)
    
    var body: some View {
        Text(text)
            .font(.system(size: size, weight: weight))
            .foregroundStyle(color)
    }
}

#Preview {
    CCTextView(text: "Vince Muller", size: 16, weight: .semibold)
}
