//
//  HomeView.swift
//  NutriGenie
//
//  Created by simge on 7.03.2024.
//

import SwiftUI

struct HomeView: View {
    @State private var selection = 0
    var tabs = ["Sweet", "Breakfast", "Lunch", "Dinner"]
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                HStack {
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
                        
                        selectedView
                    }
                    .padding(10)
                    Spacer()
                }
            }
        }
    }
    
    private var segmentedControl: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(0..<4) { index in
                    Button(action: {
                        self.selection = index
                    }) {
                        Text(tabs[index])
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(self.selection == index ? .black : .gray)
                            .font(Font.body.bold())
                    }
                    if index != tabs.count - 1 {
                        
                    }
                }
            }
        }
    }
    
    private var selectedView: some View {
        Group {
            if selection == 0 {
                SweetView()
            } else if selection == 1 {
                SweetView()
            } else if selection == 2 {
                SweetView()
            } else {
                SweetView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
                    Text("Explore the recipes")
                        .foregroundColor(.gray)
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
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                }
            }
        }
        .padding(8)
    }
}



#Preview {
    HomeView()
}

