//
//  CountdownViewModel.swift
//  Brush WatchKit Extension
//
//  Created by Bastiaan Jansen on 29/09/2020.
//

import Foundation

enum ActionState: Int {
    case countdown = 0
    case timerView = 1
}

class CountdownViewModel: ObservableObject {
    @Published var maxSeconds: Int = 3
    @Published var currentSeconds: Int = 3
    @Published var progress: Float = 1.0
    @Published var actionState: ActionState? = .countdown
    
    var timer: Timer?
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] timer in
            if currentSeconds > 0 {
                currentSeconds -= 1
                progress = Float(currentSeconds) / Float(maxSeconds)
            } else if currentSeconds == 0 {
                stopTimer()
                actionState = .timerView
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
}
