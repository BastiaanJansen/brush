//
//  ResultViewModel.swift
//  Brush WatchKit Extension
//
//  Created by Bastiaan Jansen on 28/09/2020.
//

import Foundation
import HealthKit

class ResultViewModel: ObservableObject {
    
    @Published var seconds: Int = 0
    @Published var goalTime = UserDefaults.standard.integer(forKey: "goalTime")
    
    init(seconds: Int) {
        self.seconds = seconds
    }
    
    func saveSession() {
        let end = Date()
        var start = end
        start.changeSeconds(by: -seconds)
        saveData(value: seconds, start: start, end: end)
    }
    
    private func saveData(value: Int, start: Date, end: Date) {
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
            print("Healthkit is not available")
        }
    }
    
}
