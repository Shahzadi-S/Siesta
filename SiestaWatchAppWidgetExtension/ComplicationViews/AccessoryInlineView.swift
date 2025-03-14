//
//  AccessoryInlineView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 13/03/2025.
//


import SwiftUI
import WidgetKit

struct AccessoryInlineView: View {
    var body: some View {
        Text("SIESTA")
            .widgetAccentable()
            .containerBackground(for: .widget) { }
    }
}

struct AccessoryInline_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryInlineView()
            .previewContext(WidgetPreviewContext(family: .accessoryInline))
    }
}
