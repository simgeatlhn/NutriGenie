//
//  HomeView.swift
//  NutriGenie
//
//  Created by simge on 7.03.2024.
//

import SwiftUI

struct HomeView: View {
    @State private var selection = 0
    @State private var searchText = ""
    var tabs = ["Lunch", "Dinner", "Sweet", "Breakfast"]
    @StateObject var viewModel = RecipeViewModel()
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    Text("Find Your Best")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    
                    Text("Cooking Recipes")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    
                    searchSection(geometry: geometry)
                    
                    segmentedControl
                    
                    if viewModel.filteredRecipes.isEmpty {
                        ProgressView()
                            .onAppear {
                                viewModel.fetchRecipes()
                            }
                    } else {
                        CardView(viewModel: viewModel)
                    }
                }
                .padding(.top)
            }
        }
        .onAppear {
            viewModel.fetchRecipes()
        }
    }
    
    private var segmentedControl: some View {
        HStack {
            ForEach(0..<tabs.count, id: \.self) { index in
                Button(action: {
                    self.selection = index
                    viewModel.applyFilter(category: tabs[index])
                }) {
                    Text(tabs[index])
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(self.selection == index ? .black : .gray)
                        .font(Font.body.bold())
                }
            }
        }
        .padding(.horizontal)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private func searchSection(geometry: GeometryProxy) -> some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.1))
                    .frame(width: geometry.size.width * 0.75, height: 50)
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Explore the recipes", text: $viewModel.searchText)
                        .foregroundColor(.gray)
                        .onReceive(viewModel.$searchText) { searchText in
                            viewModel.onSearchTextChange(selection: selection, tabs: tabs)
                        }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
            }
            
            NavigationLink(destination: CameraView()) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.black)
                        .frame(width: geometry.size.width * 0.15, height: 50)
                    
                    Image(systemName: "camera.viewfinder")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    HomeView()
}


