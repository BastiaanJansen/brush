//
//  TimerViewModel.swift
//  Brush WatchKit Extension
//
//  Created by Bastiaan Jansen on 19/09/2020.
//

import SwiftUI
import HealthKit

class TimerViewModel: ObservableObject {
    @Published var showResultView: Bool = false
    @Published var progress: Float = 0.0
    @Published var color: Color = .blue
    @Published var seconds: Int = 0
    
    var timer: Timer?
    
    var goalTime: Int {
        UserDefaults.standard.integer(forKey: "goalTime")
    }

    @objc func fireTimer() {
        seconds += 1
        progress = Float(seconds) / Float(goalTime)
        
        if progress >= 1 {
            color = .green
        }
    }
    
    func startSession() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.fireTimer), userInfo: nil, repeats: true)
    }
    
    func stopSession() {
        timer?.invalidate()
        showResultView.toggle()
        
        let end = Date()
        var start = end
        start.changeSeconds(by: -seconds)
        saveData(value: seconds, start: start, end: end)
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
