//
//  RecipesView.swift
//  NutriGenie
//
//  Created by simge on 12.03.2024.
//

import SwiftUI

struct RecipesView: View {
    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 8) {
                Text("8 recipes are Generated ✨")
                    .font(.title2)
                    .foregroundColor(.black)
                    .bold()
                Text("Egg, leek, tomato, mushroom, green chilli...")
            }
            .padding(.top, 32)
            .padding(.bottom, 24)
            VStack(alignment: .leading, spacing: 8) {
                RecipeView()
                RecipeView()
                RecipeView()
                RecipeView()
                RecipeView()
                RecipeView()
            }
            .padding(.horizontal, 8)
        }
    }
}


#Preview {
    RecipesView()
}
