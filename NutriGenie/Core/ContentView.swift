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
            
            HomeView()
                .tabItem {
                    Image(systemName: "clock")
                    Text("Timer")
                }
            
            HomeView()
                .tabItem {
                    Image(systemName: "bookmark")
                    Text("Saved")
                }
            
            HomeView()
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
