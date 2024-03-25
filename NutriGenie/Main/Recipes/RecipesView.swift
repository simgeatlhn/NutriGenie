//
//  RecipesView.swift
//  NutriGenie
//
//  Created by simge on 12.03.2024.
//

import SwiftUI

struct RecipesView: View {
    var body: some View {
        NavigationView {
            ScrollView (.vertical, showsIndicators: false) {
                    LazyVStack(alignment: .leading, spacing: 8) {
                        Text("8 recipes are Generated ✨")
                            .font(.title2)
                            .foregroundColor(.black)
                            .bold()
                        Text("Egg, leek, tomato, mushroom, green chilli...")
                    }
                    .padding(.vertical)
                    .padding(.top, 18)
                    .padding([.leading, .trailing], 18)
                    NavigationLink(destination: RecipeDetailView()) {
                        RecipeView()
                    }
                    NavigationLink(destination: RecipeDetailView()) {
                        RecipeView()
                    }
                    NavigationLink(destination: RecipeDetailView()) {
                        RecipeView()
                    }
            }
        }
    }
}



#Preview {
    RecipesView()
}
