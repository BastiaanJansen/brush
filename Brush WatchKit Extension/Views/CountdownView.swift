//
//  CountdownView.swift
//  Brush WatchKit Extension
//
//  Created by Bastiaan Jansen on 28/06/2020.
//

import SwiftUI

struct CountdownView: View {
    @State var maxSeconds: Int = 3
    @State var currentSeconds: Int = 3
    @State var progress: Float = 1.0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            ProgressBar(progress: $progress, color: .constant(Color.blue))
                .frame(width: 140, height: 140)
            Text("\(currentSeconds)")
                .font(.title)
                .bold()
                .onReceive(timer) { _ in
                    if currentSeconds > 0 {
                        currentSeconds -= 1
                        progress = Float(currentSeconds) / Float(maxSeconds)
                    }
                }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownView()
    }
}
