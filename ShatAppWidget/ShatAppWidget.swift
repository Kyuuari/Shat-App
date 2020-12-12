//
//  ShatAppWidget.swift
//  ShatAppWidget
//
//  Created by Chester Cari on 2020-12-08.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    @ObservedObject var messageViewModel = WidgetMessageViewModel()
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), model: "message")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        messageViewModel.fetchDataFromAPI()
        let entry = SimpleEntry(date: Date(), model: messageViewModel.text)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        messageViewModel.fetchDataFromAPI()
        print(messageViewModel.text)
        
//        let enter = SimpleEntry(date: Date(), model:messageViewModel.text)
        var entries: [SimpleEntry] = []
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        
        let nextUpdateDate = Calendar.current.date(byAdding: .minute, value: 1, to: Date())!
        
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, model: messageViewModel.text)
            entries.append(entry)
        }

//        let timeline = Timeline(entries: entries, policy: .atEnd)
        let timeline = Timeline(entries: entries, policy: .after(nextUpdateDate))
        completion(timeline)
    }
    

}

struct SimpleEntry: TimelineEntry {
    let date: Date
    var model: String
}

struct ShatAppWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            Text("Last Message")
                .font(.system(size: 14))
                .bold()
            
            Text(entry.model)
            Spacer()
            HStack{
                Spacer()
                Text(entry.date, style: .time)
                    .foregroundColor(.secondary)
                    .font(.footnote)
            }

                
        }.padding(14)
    }
}

@main
struct ShatAppWidget: Widget {
    let kind: String = "ShatAppWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ShatAppWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct ShatAppWidget_Previews: PreviewProvider {
    static var previews: some View {
        ShatAppWidgetEntryView(entry: SimpleEntry(date: Date(),model: "Hello"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
