//
//  TimerView.swift
//  Brush WatchKit Extension
//
//  Created by Bastiaan Jansen on 27/06/2020.
//

import SwiftUI
import HealthKit

struct TimerView: View {
    
    @ObservedObject var timerVM = TimerViewModel()
    
    var body: some View {
        ZStack {
            ProgressBar(progress: $timerVM.progress, color: $timerVM.color)
                .frame(width: 140, height: 140)
                .padding(20)
            
            Text(String(timerVM.seconds))
                .font(.title)
                .bold()
        }.onTapGesture {
            timerVM.stopSession()
        }.sheet(isPresented: $timerVM.showResultView) {
            ResultView(seconds: timerVM.seconds)
        }
        .onAppear {
            timerVM.startSession()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct ProgressBar: View {
    @Binding var progress: Float
    @Binding var color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 13.0)
                .foregroundColor(color)
                .opacity(0.3)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(max(progress, 0.005), 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 17, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
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
