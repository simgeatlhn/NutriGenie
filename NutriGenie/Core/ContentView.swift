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
        }
        .accentColor(.black)
    }
}

#Preview {
    ContentView()
}
