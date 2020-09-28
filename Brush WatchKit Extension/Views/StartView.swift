//
//  Startiew.swift
//  Brush WatchKit Extension
//
//  Created by Bastiaan Jansen on 27/06/2020.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationLink(destination: TimerView()) {
            ZStack {
                Circle()
                    .overlay(
                        Circle()
                            .stroke(Color.accentColor, lineWidth: 5)
                    )
                    .foregroundColor(Color.gray.opacity(0.2))
                    .frame(width: 120, height: 120, alignment: .center)
                Text("Start").foregroundColor(.accentColor)
                    .font(.title2)
                    .bold()
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct Startiew_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
