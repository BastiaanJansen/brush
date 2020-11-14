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
            NavigationView {
                SettingsView().navigationTitle("Brush")
            }
            .tabItem {
                Text("Settings")
            }.tag(1)

            NavigationView {
                StartView().navigationBarTitle("Brush")
            }
            .tabItem() {
                Text("Start")
            }.tag(2)

            NavigationView {
                HistoryView().navigationTitle("History")
            }
            .tabItem {
                Text("History")
            }.tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
