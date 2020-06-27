//
//  BrushApp.swift
//  Brush WatchKit Extension
//
//  Created by Bastiaan Jansen on 27/06/2020.
//

import SwiftUI

@main
struct BrushApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
