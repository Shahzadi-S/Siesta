//
//  AccessoryCircularView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 13/03/2025.
//


import SwiftUI
import WidgetKit

struct AccessoryCircularView: View {
    @Environment(\.widgetRenderingMode) private var widgetRenderingMode
    
    let name: String
    private let themeColors: [Color] = [.blue, .green, .yellow, .red]
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(Color(red: 1, green: 0.569, blue: 0.302))
                .opacity(widgetRenderingMode != .fullColor ? 0.2 : 1)
            HStack {
                ForEach(0..<themeColors.count, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 1)
                        .widgetAccentable()
                        .foregroundStyle(themeColors[index])
                        .opacity(0.7)
                        .frame(width: 6, height: 20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 1)
                                .stroke(.white, lineWidth: 0.5)
                        ).padding(-1)
                }
            }
        }
        .widgetLabel(name)
        .containerBackground(for: .widget) { }
    }
}

struct AccessoryCircularView_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryCircularView(name: "")
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
