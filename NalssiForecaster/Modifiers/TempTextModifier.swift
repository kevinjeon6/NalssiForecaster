//
//  TempTextModifier.swift
//  NalssiForecaster
//
//  Created by Kevin Mattocks on 5/31/22.
//

import SwiftUI

struct TempTextModifier: ViewModifier {
    var size: CGFloat
    
    func body(content: Content) -> some View {
        content.foregroundColor(.white)
            .font(.system(size: size, weight: .bold, design: .rounded))
    }
}
