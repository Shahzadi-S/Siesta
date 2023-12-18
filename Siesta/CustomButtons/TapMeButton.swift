//
//  TapMeButton.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 18/12/2023.
//

import Foundation
import SwiftUI

struct TapMeButton: ButtonStyle {
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.background)
            .foregroundStyle(color)
            .frame(width: 70, height: 70, alignment: .center)
            .background(color.cornerRadius(50.0).opacity(0.7))
    }
}
