//
//  RibbonWidget.swift
//  RibbonWidget
//
//  Created by Carmen Lucas on 9/7/23.
//

import WidgetKit
import SwiftUI

struct SmallProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SmallEntry {
        SmallEntry(date: Date(), ribbon: Ribbon(), configuration: SmallChoiceConfigIntent())
    }

    func getSnapshot(for configuration: SmallChoiceConfigIntent,in context: Context, completion: @escaping (SmallEntry) -> ()) {
        let ribbon = RibbonsDataStore().ribbons.randomElement() ?? Ribbon()
        let entry = SmallEntry(date: Date(), ribbon: ribbon, configuration: configuration)
        completion(entry)
    }

    func selectedRibbon (for configuration: SmallChoiceConfigIntent) -> Ribbon {
        guard let id = configuration.selectedRibbon?.identifier else {
            return Ribbon.instructionRibbon
        }
        return RibbonsDataStore().ribbons.first{$0.id == id} ?? Ribbon.instructionRibbon
    }
    func getTimeline(for configuration: SmallChoiceConfigIntent,in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        let currentDate = Date()
 
            let entryDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)!
        let ribbon = selectedRibbon(for: configuration)
        let entry = SmallEntry(date: entryDate, ribbon: ribbon, configuration: configuration)
       

        let timeline = Timeline(entries: [entry], policy: .after(entryDate))
        completion(timeline)
    }
}

struct SmallEntry: TimelineEntry {
    let date: Date
    let ribbon: Ribbon
    let configuration: SmallChoiceConfigIntent
}

struct SmallWidgetEntryView : View {
    var entry: SmallProvider.Entry

    var body: some View {
        RibbonItemView(ribbon: entry.ribbon)
            .scaleEffect(WidgetSize.scaleFactor)
            .widgetURL(URL(string: "ribbon:///\(entry.ribbon.id)"))
    }
}

struct SmallWidget: Widget {
    let kind: String = "SmallWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: SmallChoiceConfigIntent.self, provider: SmallProvider()) { entry in
            SmallWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Ribbons")
        .description("Add a random ribbon to your home screen.")
        .supportedFamilies([.systemSmall])
    }
}

struct SmallWidget_Previews: PreviewProvider {
    static var previews: some View {
        SmallWidgetEntryView(entry: SmallEntry(date: Date(), ribbon: Ribbon.mockRibbons[3], configuration: SmallChoiceConfigIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}


