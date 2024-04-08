//
//  RecipeModel.swift
//  NutriGenie
//
//  Created by simge on 12.03.2024.
//

import Foundation

struct Recipe: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let imageName: String
}
