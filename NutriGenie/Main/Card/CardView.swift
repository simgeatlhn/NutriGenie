//
//  CardView.swift
//  NutriGenie
//
//  Created by simge on 16.03.2024.
//

import SwiftUI

struct CardView: View {
    @StateObject var viewModel = RecipeViewModel()
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(spacing: 0) {
                            ForEach(viewModel.recipes) { recipe in
                                card(for: recipe, with: geometry)
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
    }
    
    @ViewBuilder
    func card(for recipe: Recipe, with geometry: GeometryProxy) -> some View {
        ZStack {
            if let imageURL = recipe.imageURL, let url = URL(string: imageURL) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width - 16, height: geometry.size.height - 16)
                            .cornerRadius(15)
                    case .failure:
                        Image(systemName: "photo")
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Color.gray
            }
            overlay(for: recipe)
        }
        .frame(width: geometry.size.width - 16, height: geometry.size.height - 16)
        .padding()
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
                .padding()
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
