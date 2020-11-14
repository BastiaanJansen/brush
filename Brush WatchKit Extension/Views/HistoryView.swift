//
//  HistoryView.swift
//  Brush WatchKit Extension
//
//  Created by Bastiaan Jansen on 27/06/2020.
//

import SwiftUI
import HealthKit

struct HistoryView: View {
    
    @ObservedObject var historyVM = HistoryViewModel()
    let goalTime = UserDefaults.standard.integer(forKey: "goalTime")
    
    var body: some View {
//        ScrollView {
//            VStack(spacing: 10) {
//                Text("Average session".uppercased())
//                    .font(.system(size: 13))
//                    .bold()
//                Text("\(historyVM.averageSeconds)")
//                    .font(.largeTitle)
//                    .bold()
//                    .foregroundColor(historyVM.averageSeconds >= goalTime ? .green : .red)
//                Text("Seconds")
//                    .font(.system(size: 12))
//                    .foregroundColor(.gray)
//            }
//
//            Spacer(minLength: 20)
//            Divider()
//            Spacer(minLength: 20)
//
//            LazyVStack(spacing: 10) {
//                ForEach(historyVM.data, id: \.self) { sample in
//                    NavigationLink(destination: SampleView(sample: sample)) {
//                        ItemView(sample: sample)
//                    }
//                }
//            }
//        }
        
        List {
            ForEach(historyVM.data, id: \.self) { sample in
                ItemView(sample: sample)
            }.onDelete(perform: { indexSet in
                for index in indexSet {
                    historyVM.deleteSample(sample: historyVM.data[index])
                }
                
                WKInterfaceDevice.current().play(.success)
            })
        }.listStyle(CarouselListStyle())
    }
}

struct ItemView: View {
    let sample: HKCategorySample
    let goalTime = UserDefaults.standard.integer(forKey: "goalTime")
    
    var seconds: Int {
        (sample.endDate - sample.startDate).second!
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                if seconds >= goalTime {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.title2)
                } else {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                        .font(.title2)
                }
                
                Spacer()
                
                Text(formatDate(sample.startDate))
                    .font(.caption2)
            }
            
            VStack(alignment: .leading) {
                Text("\(seconds)")
                    .font(.title)
                    .bold()
                Text("Seconds")
                    .font(.caption)
            }
        }
        .padding(.vertical)
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, HH:mm"
        return formatter.string(from: date)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
