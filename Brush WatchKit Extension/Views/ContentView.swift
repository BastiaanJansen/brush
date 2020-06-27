//
//  ContentView.swift
//  Brush WatchKit Extension
//
//  Created by Bastiaan Jansen on 27/06/2020.
//

import SwiftUI

struct ContentView: View {
    
    @State var showTimerView = false
    
    var body: some View {
        NavigationView {
            NavigationLink(destination: TimerView()) {
                ZStack {
                    Circle()
                        .overlay(
                            Circle()
                            .stroke(Color("AccentColor"), lineWidth: 5)
                        )
                        .foregroundColor(Color.gray.opacity(0.2))
                        .frame(width: 120, height: 120, alignment: .center)
                    Text("Start")
                }
            }
            .buttonStyle(PlainButtonStyle())
            .navigationBarTitle("Brush")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
