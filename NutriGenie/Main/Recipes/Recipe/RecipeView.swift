//
//  RecipeView.swift
//  NutriGenie
//
//  Created by simge on 12.03.2024.
//

import SwiftUI

struct RecipeView: View {
    var recipe: Recipe
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.title3)
                    .foregroundColor(.black)
                Text(recipe.ingredients.joined(separator: ", "))
                    .font(.body)
                    .foregroundColor(.black)
                    .padding(.top, 5)
            }
            Spacer()
            if let imageURL = recipe.imageURL, let url = URL(string: imageURL) {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 120, height: 100)
                .cornerRadius(15)
            } else {
                Image("placeholder")
                    .resizable()
                    .frame(width: 120, height: 100)
                    .cornerRadius(15)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding([.leading, .trailing], 14)
        .padding(.bottom, 10)
    }
}
