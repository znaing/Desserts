//
//  MealDBApp.swift
//  MealDB
//
//  Created by Zaid Naing on 11/17/23.
//

import SwiftUI

@main
struct MealDBApp: App {
    @AppStorage ("darkMode") private var darkMode = false
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(darkMode ? .dark : .light)
        }
    }
}
