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

    var body: some Scene {
        WindowGroup {
            ContentView() // or your initial view
                .environmentObject(recipeViewModel)
        }
    }
}

