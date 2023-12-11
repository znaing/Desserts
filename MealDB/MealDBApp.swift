//
//  MealDBApp.swift
//  MealDB
//
//  Created by Zaid Naing on 11/17/23.
//

import SwiftUI

@main
struct MealDBApp: App {
    @AppStorage ("isDarkMode") private var isDarkMode = false
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
