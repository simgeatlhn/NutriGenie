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
    @Published var savedRecipes = [Recipe]()
    @Published var searchText = ""
    
    init() {
        loadSavedRecipes()
    }

    func fetchRecipes() {
        guard let url = URL(string: "http:/192.168.1.197:3000/recipes") else { return }
        
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
        }
        .resume()
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
    
    func loadSavedRecipes() {
        savedRecipes = UserDefaultsManager.shared.getSavedRecipes()
    }
    
    func saveRecipe(_ recipe: Recipe) {
        UserDefaultsManager.shared.saveRecipe(recipe)
        loadSavedRecipes()
    }
    
    func applySearchFilter(searchText: String, category: String) {
        filteredRecipes = recipes.filter { recipe in
            let isMatchingCategory = category == "All" || recipe.category.contains(category)
            let isMatchingSearchText = searchText.isEmpty || recipe.name.localizedCaseInsensitiveContains(searchText)
            return isMatchingCategory && isMatchingSearchText
        }
        if filteredRecipes.isEmpty && !searchText.isEmpty {
            filteredRecipes = recipes.filter { recipe in
                return category == "All" || recipe.category.contains(category)
            }
        }
    }
    
    func onSearchTextChange(selection: Int, tabs: [String]) {
        applySearchFilter(searchText: searchText, category: tabs[selection])
    }
    
}

