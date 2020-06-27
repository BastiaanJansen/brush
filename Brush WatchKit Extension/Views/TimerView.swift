//
//  TimerView.swift
//  Brush WatchKit Extension
//
//  Created by Bastiaan Jansen on 27/06/2020.
//

import SwiftUI
import HealthKit

struct TimerView: View {
    
    @State var seconds: Float = 0.0
    @State var progress: Float = 0.0
    
    var goalTime: Float {
        UserDefaults.standard.float(forKey: "goalTime")
    }
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            ProgressBar(progress: $progress)
                .frame(width: 140, height: 140)
                .padding(20)
            
            Text(String(format: "%.0f", seconds))
                .font(.title)
                .bold()
                .onReceive(timer) { _ in
                    seconds += 1
                    progress = seconds / goalTime
                    
                    if (seconds == goalTime) {
                        WKInterfaceDevice.current().play(WKHapticType.success)
                    }
                }
        }.onTapGesture {
            timer.upstream.connect().cancel()
            let end = Date()
            var start = end
            start.changeSeconds(by: -Int(round(seconds)))
            saveData(value: Int(round(seconds)), start: start, end: end)
        }
    }
    
    func saveData(value: Int, start: Date, end: Date) {
        if HKHealthStore.isHealthDataAvailable() {
            let healthStore = HKHealthStore()
            let type = HKObjectType.categoryType(forIdentifier: .toothbrushingEvent)
            let toothbrushEvent = HKCategorySample(type: type!, value: HKCategoryValue.notApplicable.rawValue, start: start, end: end)
            
            healthStore.save(toothbrushEvent) { success, error in
                if error != nil {
                    fatalError(error?.localizedDescription ?? "Something went wrong")
                }
            }
        } else {
            fatalError("Healthkit is not available")
        }
    }
}

struct ProgressBar: View {
    @Binding var progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 15.0)
                .opacity(0.3)
                .foregroundColor(Color("AccentColor"))
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(max(progress, 0.005), 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color("AccentColor"))
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
