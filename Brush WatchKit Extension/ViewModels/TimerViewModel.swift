//
//  TimerViewModel.swift
//  Brush WatchKit Extension
//
//  Created by Bastiaan Jansen on 19/09/2020.
//

import SwiftUI
import HealthKit

class TimerViewModel: NSObject, ObservableObject, WKExtendedRuntimeSessionDelegate {
    @Published var showResultView: Bool
    @Published var progress: Float
    @Published var color: Color
    @Published var seconds: Int
    
    var timer: Timer = Timer()
    
    var goalTime: Int {
        UserDefaults.standard.integer(forKey: "goalTime")
    }
    
    var session = WKExtendedRuntimeSession()
    
    init(seconds: Int) {
        self.showResultView = false
        self.seconds = seconds
        self.progress = Float(seconds) / Float(UserDefaults.standard.integer(forKey: "goalTime"))
        self.color = .accentColor
    }

    @objc func fireTimer() {
        seconds += 1
        progress = Float(seconds) / Float(goalTime)
        
        if progress == 1 {
            color = .green
            
            WKInterfaceDevice.current().play(.success)
        }
    }
    
    func startSession() {
        session.delegate = self
        session.start()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.fireTimer), userInfo: nil, repeats: true)
    }
    
    func stopSession() {
        timer.invalidate()
        session.invalidate()
        showResultView.toggle()
    }
    
    // MARK:- Extended Runtime Session Delegate Methods
    func extendedRuntimeSessionDidStart(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        print("Session started at", Date())
    }
        
    func extendedRuntimeSession(_ extendedRuntimeSession: WKExtendedRuntimeSession, didInvalidateWith reason: WKExtendedRuntimeSessionInvalidationReason, error: Error?) {
        print("Session stopped at", Date())
    }
    
    func extendedRuntimeSessionWillExpire(_ extendedRuntimeSession: WKExtendedRuntimeSession) {}
}
