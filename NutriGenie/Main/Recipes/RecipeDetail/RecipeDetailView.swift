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
        ScrollView {
            VStack {
                if let imageURL = recipe.imageURL, let url = URL(string: imageURL) {
                    AsyncImage(url: url) { phase in
                        if let image = phase.image {
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                        } else if phase.error != nil {
                            Image("placeholder") 
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 480)
                        } else {
                            ProgressView()
                                .frame(height: 480)
                        }
                    }
                    .frame(height: 480)
                    .clipped()
                } else {
                    Image("placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 480)
                        .clipped()
                }
                
                Text(recipe.name)
                    .font(.title2)
                    .padding()
                
                HStack(spacing: 40){
                    VStack{
                        Image(systemName: "heart")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(6)
                        Text("Favorite")
                            .foregroundColor(.black)
                            .font(.footnote)
                    }
                    
                    VStack{
                        Image(systemName: "timer")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(6)
                        Text("\(recipe.cookingTime) min")
                            .foregroundColor(.black)
                            .font(.footnote)
                    }
                    
                    VStack{
                        Image(systemName: "fork.knife.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(6)
                        Text("Serves 4")
                            .foregroundColor(.black)
                            .font(.footnote)
                    }
                    
                    VStack{
                        Image(systemName: "figure.cooldown")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(6)
                        Text("540 kcal")
                            .foregroundColor(.black)
                            .font(.footnote)
                    }
                }
                .padding(.horizontal)
                
                Text(recipe.ingredients.joined(separator: ", "))
                    .font(.footnote)
                    .padding()
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .edgesIgnoringSafeArea(.top)
        .navigationTitle("")
        
        Button(action: {
            // Watch video action
        }) {
            Text("Watch Video")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.black)
                .cornerRadius(10)
                .padding()
        }
        .padding(.horizontal)
    }
}
