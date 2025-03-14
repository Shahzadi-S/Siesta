//
//  SiestaWatchAppWidgetExtension.swift
//  SiestaWatchAppWidgetExtension
//
//  Created by Sanaa Shahzadi on 09/03/2025.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func getSnapshot(in context: Context, completion: @escaping @Sendable (SimpleEntry) -> Void) {
        completion(SimpleEntry(date: Date()))
    }
    
    func getTimeline(in context: Context, completion: @escaping @Sendable (Timeline<SimpleEntry>) -> Void) {
        let entries: [SimpleEntry] = [SimpleEntry(date: Date())]
        completion(Timeline(entries: entries, policy: .atEnd))
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    let name: String = "SIESTA"
}

struct SiestaWatchAppWidgetExtensionEntryView : View {
    @Environment(\.widgetFamily) private var family
    
    var entry: Provider.Entry
    let themeColors: [Color] = [.blue, .green, .yellow, .red]
    
    var body: some View {
        switch family {
        case .accessoryCircular:
            AccessoryCircularView(name: entry.name)
            
        case .accessoryCorner:
            AccessoryCornerView(name: entry.name)
            
        case .accessoryInline:
            AccessoryInlineView()
            
        case .accessoryRectangular:
            AccessoryRectangularView(name: entry.name)
            
        @unknown default:
            Text("Unsupported widget")
        }
    }
}

@main
struct SiestaWatchAppWidgetExtension: Widget {
    let kind: String = "SiestaWatchAppWidgetExtension"
    var body: some WidgetConfiguration {
        
        StaticConfiguration(
            kind: kind,
            provider: Provider()
        ) { entry in
            SiestaWatchAppWidgetExtensionEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Siesta")
        .description("Easy access to your favourite game")
        .supportedFamilies([.accessoryCircular, .accessoryCorner, .accessoryInline, .accessoryRectangular])
    }
}

#Preview(as: .accessoryCircular) {
    SiestaWatchAppWidgetExtension()
} timeline: {
    SimpleEntry(date: .now)
}
