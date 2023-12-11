//  SettingsView.swift
//  MealDB
//  Created by Zaid Naing on 11/17/23.

import SwiftUI

struct SettingsView: View {
    @AppStorage ("isDarkMode") private var isDarkMode = false
    @State private var showSheet = false
    var body: some View {
        NavigationStack {
            ZStack {
                AnimatedBackground()
                VStack {
                    Form {
                        //Toggles between dark and light mode
                        Toggle("Dark Mode", isOn: $isDarkMode)
                        //Presents a sheet that lets the user change the app icon
                        Button("Change App Icon") {
                            showSheet = true
                            let impactMed = UIImpactFeedbackGenerator(style: .rigid)
                            impactMed.impactOccurred()
                        }
                        .sheet(isPresented: $showSheet) {
                            AppIconView()
                                .presentationDetents([.height(300)])
                                .presentationDragIndicator(.automatic)
                                
                        }
                    }
                    .scrollContentBackground(.hidden)
                    WebViewButton()
                }
                
            }
            .navigationTitle("Settings")
        }
    }
}

///Web view that routes to my personal page
struct WebViewButton: View {
    var body: some View {
        HStack{
            Text("made by")
            Button(action: {
                // Define the URL string.
                if let url = URL(string: "https://bento.me/zaidnaing") {
                    // Open the URL in the default browser.
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }) {
                Text("@zaid")
                    .foregroundColor(.primary)
                    .underline()
            }
        }.padding(.bottom)
    }
}

#Preview {
    SettingsView()
}
