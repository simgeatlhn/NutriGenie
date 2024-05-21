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
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 8) {
                    Text("\(viewModel.savedRecipes.count) Saved Recipes ✨")
                        .font(.title2)
                        .foregroundColor(.black)
                        .bold()
                        .padding(.vertical)
                        .padding([.leading, .trailing], 18)
                    
                    ForEach(viewModel.savedRecipes, id: \.id) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            RecipeView(recipe: recipe)
                        }
                    }
                }
            }
           // .navigationBarTitle("Saved Recipes")
        }
    }
}



#Preview {
    SavedRecipesView()
        .environmentObject(RecipeViewModel())
}
