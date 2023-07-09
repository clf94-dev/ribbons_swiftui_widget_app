//
//  MediumWidget.swift
//  RibbonWidgetExtension
//
//  Created by Carmen Lucas on 9/7/23.
//

import WidgetKit
import SwiftUI

struct MediumProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> MediumEntry {
        MediumEntry(date: Date(), ribbon: Ribbon(), ribbon2: Ribbon(), configuration: MediumChoiceConfigIntent())
    }

    func getSnapshot(for configuration: MediumChoiceConfigIntent,in context: Context, completion: @escaping (MediumEntry) -> ()) {
        let ribbon = RibbonsDataStore().ribbons.randomElement() ?? Ribbon()
        let ribbon2 = RibbonsDataStore().ribbons.randomElement() ?? Ribbon()
        let entry = MediumEntry(date: Date(), ribbon: ribbon, ribbon2: ribbon2, configuration: configuration)
        completion(entry)
    }

    func selectedRibbon (for configuration: MediumChoiceConfigIntent, selection: Int) -> Ribbon {
        var selectedId = ""
        switch selection{
        case 1:
            guard let id = configuration.selectedRibbon1?.identifier else {
                return Ribbon.instructionRibbon
            }
            selectedId = id
            
        default:
            guard let id = configuration.selectedRibbon2?.identifier else {
                return Ribbon.instructionRibbon
            }
            selectedId = id
        }
        return RibbonsDataStore().ribbons.first{$0.id == selectedId} ?? Ribbon.instructionRibbon
    }
    func getTimeline(for configuration: MediumChoiceConfigIntent,in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        let currentDate = Date()
 
        let entryDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)!
        let ribbon = selectedRibbon(for: configuration, selection: 1)
        let ribbon2 = selectedRibbon(for: configuration, selection: 2)

        let entry = MediumEntry(date: entryDate, ribbon: ribbon, ribbon2: ribbon2, configuration: configuration)
       

        let timeline = Timeline(entries: [entry], policy: .after(entryDate))
        completion(timeline)
    }
}

struct MediumEntry: TimelineEntry {
    let date: Date
    let ribbon: Ribbon
    let ribbon2: Ribbon

    let configuration: MediumChoiceConfigIntent
}

struct MediumWidgetEntryView : View {
    var entry: MediumProvider.Entry

    var body: some View {
        HStack(spacing:20) {
            RibbonItemView(ribbon: entry.ribbon)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            RibbonItemView(ribbon: entry.ribbon2)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        } .scaleEffect(WidgetSize.scaleFactor (.medium))
    }
}

struct MediumWidget: Widget {
    let kind: String = "Medium Widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: MediumChoiceConfigIntent.self, provider: MediumProvider()) { entry in
            MediumWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Ribbons")
        .description("Add two ribbons to your home screen.")
        .supportedFamilies([.systemMedium])
    }
}

struct MediumWidget_Previews: PreviewProvider {
    static var previews: some View {
        MediumWidgetEntryView(entry: MediumEntry(date: Date(), ribbon: Ribbon.mockRibbons[3], ribbon2: Ribbon.mockRibbons[5], configuration: MediumChoiceConfigIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
