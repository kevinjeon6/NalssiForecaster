//
//  TileModifier.swift
//  NalssiForecaster
//
//  Created by Kevin Mattocks on 5/31/22.
//

import SwiftUI

struct TileModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .frame(width: 100, height: 100)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.backgroundColor)
            )
    }
}
