//
//  CountdownView.swift
//  Brush WatchKit Extension
//
//  Created by Bastiaan Jansen on 28/06/2020.
//

import SwiftUI

struct CountdownView: View {
    
    @ObservedObject var countdownVM = CountdownViewModel()
    
    var body: some View {
        NavigationLink(destination: TimerView(), tag: .timerView, selection: $countdownVM.actionState) {
            GeometryReader { g in
                ZStack {
                    ProgressBar(progress: $countdownVM.progress, color: .constant(Color.accentColor))
                        .frame(width: g.size.width - 20, height: g.size.height - 20)
                    Text("\(countdownVM.currentSeconds)")
                        .font(.title)
                        .bold()
                        .foregroundColor(.accentColor)
                }.position(x: g.size.width / 2, y: g.size.height / 2)
            }
        }.buttonStyle(PlainButtonStyle())
        .onAppear() {
            countdownVM.startTimer()
        }.onDisappear() {
            countdownVM.stopTimer()
        }
//        .navigationBarBackButtonHidden(true)
//        .navigationBarHidden(true)
    }
}

struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownView()
    }
}
