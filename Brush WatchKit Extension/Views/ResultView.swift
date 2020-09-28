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
            ScrollView {
                VStack(spacing: 20) {
                    HStack {
                        Image(systemName: seconds >= goalTime ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundColor(seconds >= goalTime ? .green : .red)
                            .font(.system(size: 50))
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("\(seconds)")
                                .font(.title)
                                .bold()
                                .foregroundColor(.accentColor)
                            Text("Seconds")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Divider()
                    
                    VStack {
                        Text("Your goal is \(goalTime) seconds")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    
                    NavigationLink(destination: ContentView()) {
                        Text("Done")
                    }

                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(seconds: 134)
    }
}
