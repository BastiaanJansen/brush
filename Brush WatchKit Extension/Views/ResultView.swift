//
//  ResultView.swift
//  Brush WatchKit Extension
//
//  Created by Bastiaan Jansen on 27/06/2020.
//

import SwiftUI

struct ResultView: View {
    
    @ObservedObject var resultVM: ResultViewModel
    
    init(seconds: Int) {
        resultVM = ResultViewModel(seconds: seconds)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    HStack {
                        Image(systemName: resultVM.seconds >= resultVM.goalTime ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundColor(resultVM.seconds >= resultVM.goalTime ? .green : .red)
                            .font(.system(size: 50))
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("\(resultVM.seconds)")
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
                        Text("Your goal is \(resultVM.goalTime) seconds")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        NavigationLink(destination: TimerView(seconds: resultVM.seconds)) {
                            Text("Back")
                        }
                        
                        NavigationLink(destination: ContentView().onAppear() {
                            resultVM.saveSession()
                        }) {
                            Text("Save")
                        }
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
