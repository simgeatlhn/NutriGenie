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
                Image("images")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 400)
                    .clipped()
                
                Text("Bread & Egg Morning Casserole")
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
                        Text("65 min")
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
                        Text("serves 4")
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
                
                Text("Egg,garlic,clove,medium onion Egg,garlic,clove,medium onion Egg,garlic,clove,medium onion...")
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



struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: Recipe(title: "Sample Recipe", description: "Sample Description", imageName: "images"))
    }
}

