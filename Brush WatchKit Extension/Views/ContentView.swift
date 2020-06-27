//
//  ContentView.swift
//  Brush WatchKit Extension
//
//  Created by Bastiaan Jansen on 27/06/2020.
//

import SwiftUI

struct ContentView: View {
    
    @State var defaultTab = 2
    
    var body: some View {
        TabView(selection: $defaultTab) {
            SettingsView()
                .tabItem {
                    Text("Settings")
                }.tag(1)
            StartView()
                .tabItem() {
                    Text("Start")
                }.tag(2)
            HistoryView()
                .tabItem {
                    Text("History")
                }.tag(3)
        }
        .font(.headline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
