//
//  Recipe.swift
//  RecipeApp
//
//  Created by Ali AKIN on 1.07.2025.
//

import Foundation

struct MealResponse: Decodable {
    let meals: [Meal]
}

struct Meal: Decodable {
    let idMeal: String?
    let strMeal: String?
    let strMealThumb: String?
}
