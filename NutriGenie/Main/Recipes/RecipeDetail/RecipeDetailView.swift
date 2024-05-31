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
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    if let imageURL = recipe.imageURL, let url = URL(string: imageURL) {
                        ZStack {
                            AsyncImage(url: url) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: UIScreen.main.bounds.width, height: 480)
                                        .clipped()
                                } else if phase.error != nil {
                                    Image("placeholder")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: UIScreen.main.bounds.width, height: 480)
                                        .clipped()
                                } else {
                                    Image("placeholder")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: UIScreen.main.bounds.width, height: 480)
                                        .clipped()
                                    VStack {
                                        Spacer()
                                        ProgressView()
                                            .padding(.bottom, 480)
                                        Spacer()
                                    }
                                    .frame(height: 480)
                                }
                            }
                        }
                    } else {
                        Image("placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: 480)
                            .clipped()
                    }
                    
                    HStack {
                        Spacer()
                        Text(recipe.name)
                            .font(.title2)
                            .padding(.vertical)
                            .bold()
                        Spacer()
                    }
                    
                    HStack(spacing: 48) {
                        VStack {
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
                        
                        VStack {
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
                        
                        VStack {
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
                        
                        VStack {
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
                    
                    Text("Ingredients")
                        .font(.headline)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    Text(recipe.ingredients.joined(separator: ", "))
                        .font(.footnote)
                        .padding(.horizontal)
                }
                .padding(.horizontal)
            }
            
            Spacer()
            
            Button(action: {
                if let videoURL = recipe.videoURL, let url = URL(string: videoURL) {
                    UIApplication.shared.open(url)
                }
            }) {
                Text("Watch Video")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .padding(.bottom, 20)
        }
        .edgesIgnoringSafeArea(.top)
        .navigationTitle("")
    }
}



