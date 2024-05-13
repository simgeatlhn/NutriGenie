//
//  RecipeViewModel.swift
//  NutriGenie
//
//  Created by simge on 10.04.2024.
//

import SwiftUI

class RecipeViewModel: ObservableObject {
    @Published var recipes = [Recipe]()
    @Published var filteredRecipes = [Recipe]()
    
    func fetchRecipes() {
        guard let url = URL(string: "http://10.33.10.174:3000/recipes") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Failed to fetch recipes:", error)
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }
            guard let decodedRecipes = try? JSONDecoder().decode([Recipe].self, from: data) else {
                print("Failed to decode recipes")
                return
            }
            
            DispatchQueue.main.async {
                self?.recipes = decodedRecipes
                self?.applyFilter(category: "All")
            }
        }.resume()
    }
    
    func applyFilter(category: String) {
        if category == "All" {
            filteredRecipes = recipes
        } else {
            filteredRecipes = recipes.filter { $0.category.contains(category) }
        }
    }
    
    func updateFilteredRecipes(with product: String) {
        filteredRecipes = recipes.filter { recipe in
            return recipe.ingredients.contains { ingredient in
                ingredient.lowercased().contains(product.lowercased())
            }
        }
    }
}

