//
//  BrushApp.swift
//  Brush WatchKit Extension
//
//  Created by Bastiaan Jansen on 27/06/2020.
//

import SwiftUI
import HealthKit

@main
struct BrushApp: App {
    
    init() {
        askHealthkitPermission()
    }
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
    
    func askHealthkitPermission() {
        if HKHealthStore.isHealthDataAvailable() {
            let healthStore = HKHealthStore()
            
            let types = Set([
                HKObjectType.categoryType(forIdentifier: .toothbrushingEvent)!
            ])
            
            healthStore.requestAuthorization(toShare: types, read: types) { success, error in
                if !success {
                    fatalError("Something went wrong")
                }
            }
        }
    }
}
