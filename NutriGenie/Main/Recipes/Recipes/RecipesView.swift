//
//  RecipesView.swift
//  NutriGenie
//
//  Created by simge on 12.03.2024.
//

import SwiftUI

struct RecipesView: View {
    var filteredRecipes: [Recipe]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 8) {
                Text("\(filteredRecipes.count) recipes are Generated ✨")
                    .font(.title2)
                    .foregroundColor(.black)
                    .bold()
                    .padding(.vertical)
                    .padding(.top, 18)
                    .padding([.leading, .trailing], 18)
                
                ForEach(filteredRecipes, id: \.id) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        RecipeView(recipe: recipe)
                    }
                }
            }
        }
        .navigationBarTitle("Filtered Recipes")
    }
}
