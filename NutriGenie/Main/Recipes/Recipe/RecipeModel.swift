//
//  RecipeModel.swift
//  NutriGenie
//
//  Created by simge on 12.03.2024.
//

import Foundation

struct Recipe: Codable, Identifiable {
    var id: String
    var name: String
    var ingredients: [String]
    var instructions: String
    var category: String
    var cookingTime: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case ingredients
        case instructions
        case category
        case cookingTime
    }
}
