//
//  CardView.swift
//  NutriGenie
//
//  Created by simge on 16.03.2024.
//

import SwiftUI

struct CardView: View {
    @StateObject var viewModel = RecipeViewModel()
    @State private var flipped = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(viewModel.filteredRecipes) { recipe in
                            card(for: recipe, with: geometry)
                                .frame(width: geometry.size.width)
                                .onTapGesture {
                                    withAnimation(.easeInOut(duration: 0.8)) {
                                        flipped.toggle()
                                    }
                                }
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .onAppear {
                    viewModel.fetchRecipes()
                }
            }
        }
    }
    
    @ViewBuilder
    func card(for recipe: Recipe, with geometry: GeometryProxy) -> some View {
        ZStack {
            Group {
                if flipped {
                    backView(for: recipe, with: geometry)
                } else {
                    frontView(for: recipe, with: geometry)
                }
            }
        }
        .frame(width: geometry.size.width - 16, height: geometry.size.height - 16)
        .cornerRadius(15)
    }
    
    @ViewBuilder
    func frontView(for recipe: Recipe, with geometry: GeometryProxy) -> some View {
        if let imageURL = recipe.imageURL, let url = URL(string: imageURL) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width - 16, height: geometry.size.height - 16)
                case .failure:
                    Image(systemName: "photo.on.rectangle.angled")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width - 16, height: geometry.size.height - 16)
                @unknown default:
                    EmptyView()
                }
            }
        } else {
            Color.white
        }
        overlay(for: recipe)
    }
    
    @ViewBuilder
    func backView(for recipe: Recipe, with geometry: GeometryProxy) -> some View {
        ZStack {
            Color.black
                .frame(width: geometry.size.width - 16, height: geometry.size.height - 16)
                .cornerRadius(15)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(recipe.name)
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top)
                    Text("Ingredients")
                        .bold()
                        .foregroundColor(.orange)
                    Text(recipe.ingredients.joined(separator: ", "))
                        .foregroundColor(.white)
                        .padding(.bottom)
                    Text("Instructions")
                        .bold()
                        .foregroundColor(.orange)
                    Text(recipe.instructions)
                        .foregroundColor(.white)
                }
                .padding()
            }
        }
    }
    
    @ViewBuilder
    func overlay(for recipe: Recipe) -> some View {
        VStack {
            HStack {
                Spacer()
                bookmarkButton()
            }
            Spacer()
            Text(recipe.name)
                .foregroundColor(.white)
                .bold()
                .padding(6)
                .background(Color.black.opacity(0.5))
                .cornerRadius(20)
        }
        .padding()
    }
    
    func bookmarkButton() -> some View {
        Button(action: {
            print("Bookmark tapped")
        }) {
            Image(systemName: "bookmark.fill")
                .foregroundColor(.white)
                .padding(10)
                .background(Circle().fill(Color.black.opacity(0.5)))
        }
    }
}

#Preview {
    CardView()
}

