//
//  CategoryModel.swift
//  RecipeApp
//
//  Created by Ali AKIN on 1.07.2025.
//

import Foundation

struct CategoryModel: Decodable {
    let categories: [Category]
}

struct Category: Decodable {
    
    let idCategory: String?
    let strCategory: String?
    let strCategoryThumb: String?
    let strCategoryDescription: String?
    
}
