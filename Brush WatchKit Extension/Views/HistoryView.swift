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
    
    var body: some View {
        List(historyVM.data, id: \.self) { sample in
            NavigationLink(destination: SampleView(sample: sample)) {
                ItemView(sample: sample)
            }
        }
        .listStyle(CarouselListStyle())
    }
}

struct ItemView: View {
    let sample: HKCategorySample
    
    var seconds: Int {
        (sample.endDate - sample.startDate).second!
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                if seconds >= UserDefaults.standard.integer(forKey: "goalTime") {
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
