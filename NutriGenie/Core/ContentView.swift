//
//  ContentView.swift
//  NutriGenie
//
//  Created by simge on 7.03.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            TimerView()
                .tabItem {
                    Image(systemName: "clock")
                    Text("Timer")
                }
            
            SavedRecipesView()
                .tabItem {
                    Image(systemName: "bookmark")
                    Text("Saved")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
        .accentColor(.black)
    }
}

#Preview {
    ContentView()
}
