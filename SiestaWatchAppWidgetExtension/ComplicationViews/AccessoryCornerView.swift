//
//  AccessoryCornerView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 13/03/2025.
//


import SwiftUI
import WidgetKit

struct AccessoryCornerView: View {
    @Environment(\.widgetRenderingMode) private var widgetRenderingMode
    
    let name: String
    private let themeColors: [Color] = [.blue, .green, .yellow, .red]
    
    var body: some View {
        ZStack {
               switch widgetRenderingMode {
               case .fullColor:
                   ZStack {
                       Circle()
                           .foregroundStyle(Color(red: 1, green: 0.569, blue: 0.302))
                           .opacity(0.9)
                       HStack {
                           ForEach(0..<themeColors.count, id: \.self) { index in
                               RoundedRectangle(cornerRadius: 1)
                                   .foregroundStyle(themeColors[index])
                                   .frame(width: 4, height: 15)
                                   .overlay(
                                       RoundedRectangle(cornerRadius: 1)
                                        .stroke(.white, lineWidth: 0.75)
                                           .widgetAccentable()
                                   ).padding(-1)
                           }
                       }
                   }
                   .widgetLabel(name)
                   .containerBackground(for: .widget) { }
               default:
                   ZStack {
                       Circle()
                       HStack {
                           ForEach(0..<themeColors.count, id: \.self) { index in
                               RoundedRectangle(cornerRadius: 1)
                                   .blendMode(.destinationOut)
                                   .frame(width: 4, height: 15)
                                   .padding(-1)
                           }
                       }
                   }
                   .compositingGroup()
                   .widgetAccentable()
                   .widgetLabel(name)
                   .containerBackground(for: .widget) { }
               }
        }
    }
}

struct AccessoryCornerView_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryCornerView(name: "")
            .previewContext(WidgetPreviewContext(family: .accessoryCorner))
    }
}
