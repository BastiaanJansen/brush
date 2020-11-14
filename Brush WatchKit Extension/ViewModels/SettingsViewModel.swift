//
//  SettingsViewModel.swift
//  Brush WatchKit Extension
//
//  Created by Bastiaan Jansen on 27/06/2020.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var goalTime: Int {
        didSet {
            UserDefaults.standard.set(goalTime, forKey: "goalTime")
        }
    }
    @Published var countdown: Bool {
        didSet {
            UserDefaults.standard.set(countdown, forKey: "countdown")
        }
    }
    
    @Published var goalTimeStep = 10
    
    let minimumGoalTime = 30
    let maximumGoalTime = 600
    
    init() {        
        self.goalTime = UserDefaults.standard.integer(forKey: "goalTime")
        self.countdown = UserDefaults.standard.bool(forKey: "countdown")
    }
    
    func changeGoalTime(step: Int) {
        let nextGoalTime: Int = goalTime + step
        if nextGoalTime >= minimumGoalTime && nextGoalTime <= maximumGoalTime {
            goalTime += step
            WKInterfaceDevice.current().play(.click)
        } else {
            WKInterfaceDevice.current().play(.failure)
        }
    }
}
