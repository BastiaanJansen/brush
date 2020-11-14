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
    @Published var seconds: Int
    
    var timer: Timer?
    var session: WKExtendedRuntimeSession?
    
    var goalTime: Int {
        UserDefaults.standard.integer(forKey: "goalTime")
    }
    
    init(seconds: Int) {
        self.showResultView = false
        self.seconds = seconds
        self.progress = Float(seconds) / Float(UserDefaults.standard.integer(forKey: "goalTime"))
    }

    func fireTimer(timer: Timer) {
        seconds += 1
        progress = Float(seconds) / Float(goalTime)
        
        if progress == 1 {
            WKInterfaceDevice.current().play(.success)
        }
    }
    
    func startSession() {
        session = WKExtendedRuntimeSession()
        session?.delegate = self
        session?.start()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: fireTimer)
    }
    
    func stopSession() {
        timer?.invalidate()
        session?.invalidate()
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
