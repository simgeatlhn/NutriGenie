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
                VStack(alignment: .leading) {
                    Text("8 recipes are Generated ✨")
                        .font(.title2)
                        .foregroundColor(.black)
                        .bold()
                    Text("Egg, leek, tomato, mushroom, green chilli...")
                }
                .padding(.vertical)
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
