//
//  RecipeViewModel.swift
//  NutriGenie
//
//  Created by simge on 10.04.2024.
//

import SwiftUI

class RecipeViewModel: ObservableObject {
    @Published var recipes = [Recipe]()
    
    func fetchRecipes() {
        guard let url = URL(string: "http://192.168.0.133:3000/recipes") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed to fetch recipes:", error)
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }
            if let decodedRecipes = try? JSONDecoder().decode([Recipe].self, from: data) {
                DispatchQueue.main.async {
                    self.recipes = decodedRecipes
                }
            } else {
                print("Failed to decode recipes")
            }
        }.resume()
    }
}
