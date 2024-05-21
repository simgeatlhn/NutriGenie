//
//  UserDefaultsManager.swift
//  NutriGenie
//
//  Created by simge on 21.05.2024.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let savedRecipesKey = "savedRecipes"
    
    private init() {}
    
    func saveRecipe(_ recipe: Recipe) {
        var savedRecipes = getSavedRecipes()
        if !savedRecipes.contains(where: { $0.id == recipe.id }) {
            savedRecipes.append(recipe)
            if let encoded = try? JSONEncoder().encode(savedRecipes) {
                UserDefaults.standard.set(encoded, forKey: savedRecipesKey)
            }
        }
    }
    
    func getSavedRecipes() -> [Recipe] {
        if let data = UserDefaults.standard.data(forKey: savedRecipesKey),
           let savedRecipes = try? JSONDecoder().decode([Recipe].self, from: data) {
            return savedRecipes
        }
        return []
    }
}

