//
//  SettingsViewModel.swift
//  Brush WatchKit Extension
//
//  Created by Bastiaan Jansen on 27/06/2020.
//

import Foundation

class SettingsViewModel: ObservableObject {
    @Published var goalTime: Int {
        didSet {
            UserDefaults.standard.set(goalTime, forKey: "goalTime")
        }
    }
    
    init() {        
        self.goalTime = UserDefaults.standard.integer(forKey: "goalTime")
    }
}
