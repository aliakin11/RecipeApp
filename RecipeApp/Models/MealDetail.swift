//
//  MealDetail.swift
//  RecipeApp
//
//  Created by Ali AKIN on 1.07.2025.
//

import Foundation

struct MealDetailResponse: Decodable {
    let meals: [MealDetail]
}


struct MealDetail: Decodable {
    let idMeal: String?
    let strMeal: String?
    let strCategory: String?
    let strInstructions: String?
    let strMealThumb: String?
}


    
