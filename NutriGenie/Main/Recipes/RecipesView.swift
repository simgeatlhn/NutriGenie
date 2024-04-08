//
//  RecipesView.swift
//  NutriGenie
//
//  Created by simge on 12.03.2024.
//

import SwiftUI

struct RecipesView: View {
    let recipes: [Recipe] = [
        Recipe(title: "Bread & Egg Morning Casserole", description: "Egg, garlic, clove, medium onion...", imageName: "image"),
        Recipe(title: "Vegetable Stir Fry", description: "Egg, leek, tomato, mushroom, green chili...", imageName: "image"),
        Recipe(title: "Grilled Salmon", description: "Salmon fillet, lemon, garlic, olive oil...", imageName: "image")
    ]

    var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 8) {
                    Text("\(recipes.count) recipes are Generated ✨")
                        .font(.title2)
                        .foregroundColor(.black)
                        .bold()
                        .padding(.vertical)
                        .padding(.top, 18)
                        .padding([.leading, .trailing], 18)

                    ForEach(recipes, id: \.title) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            RecipeView()
                        }
                    }
                }
            }
        }
}


#Preview {
    RecipesView()
}
