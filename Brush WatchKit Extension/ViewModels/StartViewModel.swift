//
//  StartViewModel.swift
//  Brush WatchKit Extension
//
//  Created by Bastiaan Jansen on 29/09/2020.
//

import Foundation

class StartViewModel: ObservableObject {
    @Published var showCountdown: Bool = UserDefaults.standard.bool(forKey: "countdown")
}
