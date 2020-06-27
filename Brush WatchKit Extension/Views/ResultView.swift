//
//  ResultView.swift
//  Brush WatchKit Extension
//
//  Created by Bastiaan Jansen on 27/06/2020.
//

import SwiftUI

struct ResultView: View {
    
    let seconds: Int
    let goalTime = UserDefaults.standard.integer(forKey: "goalTime")
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if seconds >= goalTime {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.title)
                } else {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                        .font(.title)
                }
                
                VStack {
                    Text("\(seconds)")
                        .font(.title)
                        .bold()
                    Text("Seconds")
                        .font(.footnote)
                }
                
                NavigationLink(destination: ContentView()) {
                    Text("Go back")
                }

            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(seconds: 42)
    }
}
