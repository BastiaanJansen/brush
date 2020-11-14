//
//  ProgressBar.swift
//  Brush WatchKit Extension
//
//  Created by Bastiaan Jansen on 29/09/2020.
//

import SwiftUI

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

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(progress: .constant(0.3), color: .constant(Color.accentColor))
    }
}
