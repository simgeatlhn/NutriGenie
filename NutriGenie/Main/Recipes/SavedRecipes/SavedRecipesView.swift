//
//  SavedRecipesView.swift
//  NutriGenie
//
//  Created by simge on 21.05.2024.
//

import SwiftUI

struct SavedRecipesView: View {
    @EnvironmentObject var viewModel: RecipeViewModel
    
    var body: some View {
        List(viewModel.savedRecipes) { recipe in
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.ingredients.joined(separator: ", "))
                    .font(.subheadline)
                Text(recipe.instructions)
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("Saved Recipes")
    }
}

#Preview {
    SavedRecipesView()
        .environmentObject(RecipeViewModel())
}
