//
//  TimerView.swift
//  Brush WatchKit Extension
//
//  Created by Bastiaan Jansen on 27/06/2020.
//

import SwiftUI
import HealthKit

struct TimerView: View {
    
    @ObservedObject var timerVM: TimerViewModel
    
    init(seconds: Int = 0) {
        timerVM = TimerViewModel(seconds: seconds)
    }
    
    var body: some View {
        GeometryReader { g in
            ZStack {
                ProgressBar(progress: $timerVM.progress, color: timerVM.progress < 1.0 ? .constant(Color.accentColor) : .constant(Color.green))
                    .frame(width: g.size.width - 20, height: g.size.height - 20)
                    .padding(20)
                
                Text(String(timerVM.seconds))
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.accentColor)
            }.position(x: g.size.width / 2, y: g.size.height / 2)
        }.onTapGesture {
            timerVM.stopSession()
        }.sheet(isPresented: $timerVM.showResultView) {
            ResultView(seconds: timerVM.seconds)
        }
        .onAppear {
            timerVM.startSession()
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
