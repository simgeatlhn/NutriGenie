//
//  RecipesView.swift
//  NutriGenie
//
//  Created by simge on 12.03.2024.
//

import SwiftUI

struct RecipesView: View {
    @ObservedObject var viewModel: RecipeViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 8) {
                Text("\(viewModel.recipes.count) recipes are Generated ✨")
                    .font(.title2)
                    .foregroundColor(.black)
                    .bold()
                    .padding(.vertical)
                    .padding(.top, 18)
                    .padding([.leading, .trailing], 18)
                
                ForEach(viewModel.recipes) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        RecipeView(recipe: recipe)
                    }
                }
            }
            .onAppear {
                viewModel.fetchRecipes()
            }
        }
    }
}
