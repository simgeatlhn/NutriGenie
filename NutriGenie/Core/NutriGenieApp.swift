//
//  NutriGenieApp.swift
//  NutriGenie
//
//  Created by simge on 7.03.2024.
//

import SwiftUI

@main
struct NutriGenieApp: App {
    @StateObject private var recipeViewModel = RecipeViewModel()
    @State private var showSplash = true
    
    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashView(showSplash: $showSplash)
            } else {
                ContentView()
                    .environmentObject(recipeViewModel)
            }
        }
    }
}



