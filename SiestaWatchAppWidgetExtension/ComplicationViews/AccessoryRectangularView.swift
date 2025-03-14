//
//  AccessoryRectangularView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 13/03/2025.
//


import SwiftUI
import WidgetKit

struct AccessoryRectangularView: View {
    let name: String
    private let themeColors: [Color] = [.blue, .green, .yellow, .red]
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        HStack {
            HStack {
                ForEach(0..<themeColors.count, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 1)
                        .foregroundStyle(themeColors[index])
                        .opacity(0.7)
                        .overlay(
                            RoundedRectangle(cornerRadius: 1)
                                .stroke(.white, lineWidth: 0.5)
                                .widgetAccentable()
                        )
                        .padding(0)
                }
            }
            .frame(width: 40, height: 40)
            .widgetAccentable()
            
            VStack() {
                Text(name)
                    .font(.subheadline)
                    .kerning(3)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Play Now!")
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(5)
        }
        .padding()
        .containerBackground(for: .widget) { }
    }
}

struct AccessoryRectangularView_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryRectangularView(name: "")
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
    }
}
