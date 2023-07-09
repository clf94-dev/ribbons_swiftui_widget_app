//
//  RibbonWidget.swift
//  RibbonWidget
//
//  Created by Carmen Lucas on 9/7/23.
//

import WidgetKit
import SwiftUI

struct SmallProvider: TimelineProvider {
    func placeholder(in context: Context) -> SmallEntry {
        SmallEntry(date: Date(), ribbon: Ribbon())
    }

    func getSnapshot(in context: Context, completion: @escaping (SmallEntry) -> ()) {
        let ribbon = RibbonsDataStore().ribbons.randomElement() ?? Ribbon()
        let entry = SmallEntry(date: Date(), ribbon: ribbon)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        let currentDate = Date()
 
            let entryDate = Calendar.current.date(byAdding: .minute, value: 5, to: currentDate)!
        let ribbon = RibbonsDataStore().ribbons.randomElement() ?? Ribbon()
            let entry = SmallEntry(date: entryDate, ribbon: ribbon)
       

        let timeline = Timeline(entries: [entry], policy: .after(entryDate))
        completion(timeline)
    }
}

struct SmallEntry: TimelineEntry {
    let date: Date
    let ribbon: Ribbon
}

struct SmallWidgetEntryView : View {
    var entry: SmallProvider.Entry

    var body: some View {
        RibbonItemView(ribbon: entry.ribbon)
            .scaleEffect(WidgetSize.scaleFactor)
    }
}

struct SmallWidget: Widget {
    let kind: String = "SmallWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: SmallProvider()) { entry in
            SmallWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Ribbons")
        .description("Add a random ribbon to your home screen.")
        .supportedFamilies([.systemSmall])
    }
}

struct SmallWidget_Previews: PreviewProvider {
    static var previews: some View {
        SmallWidgetEntryView(entry: SmallEntry(date: Date(), ribbon: Ribbon.mockRibbons[3]))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
