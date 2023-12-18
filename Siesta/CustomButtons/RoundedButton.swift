//
//  RoundedButton.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 18/12/2023.
//

import Foundation
import SwiftUI

struct RoundedButton: ButtonStyle {
    var color: Color
    var font: Font
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 250, height: 70, alignment: .center)
            .background(color.cornerRadius(50.0).opacity(0.2))
            .foregroundStyle(color)
            .font(font)
    }
}
