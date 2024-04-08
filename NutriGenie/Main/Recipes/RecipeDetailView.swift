//
//  RecipeDetailView.swift
//  NutriGenie
//
//  Created by simge on 17.03.2024.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        Text("Recipe: \(recipe.title)")
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: Recipe(title: "Sample Recipe", description: "Sample Description", imageName: "image"))
    }
}
