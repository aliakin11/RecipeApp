//
//  RecipeService.swift
//  RecipeApp
//
//  Created by Ali AKIN on 1.07.2025.
//

import Foundation

protocol RecipeServiceProtocol {
    
    func fetchCategories(completion: @escaping (Result<CategoryModel, NetworkError>) -> Void)
    
    func fetchRecipes(for category: String, completion: @escaping (Result<MealResponse, NetworkError>) -> Void)
    
    func fetchMealDetails(for mealID: String, completion: @escaping (Result<MealDetailResponse, NetworkError>) -> Void)
    
    func searchRecipes(for searchText: String, completion: @escaping (Result<MealResponse, NetworkError>) -> Void)
    
}

final class RecipeService: RecipeServiceProtocol {
    
    
    // MARK: - Properties
    private let networkManager: NetworkManagerProtocol
    
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    // MARK: - Methods
    
    
    func fetchCategories(completion: @escaping (Result<CategoryModel, NetworkError>) -> Void) {
        
        guard let url = URL(string: NetworkConstants.baseURL + "categories.php") else {
            completion(.failure(.invalidURL))
            return
        }
        
        networkManager.request(
            url: url,
            method: .GET,
            completion: completion
        )
        
    }
    
    func fetchRecipes(for categoryName: String, completion: @escaping (Result<MealResponse, NetworkError>) -> Void) {
        
        guard let encodedCategoryName = categoryName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                    completion(.failure(.invalidResponse))
                    return
                }
        
        guard let url = URL(string: NetworkConstants.baseURL + "filter.php?c=\(encodedCategoryName)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        networkManager.request(
            url: url,
            method: .GET,
            completion: completion
        )
     
    }
    
    func fetchMealDetails(for mealID: String, completion: @escaping (Result<MealDetailResponse, NetworkError>) -> Void) {
        
        guard let url = URL(string: NetworkConstants.baseURL + "lookup.php?i=\(mealID)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        networkManager.request(
            url: url,
            method: .GET,
            completion: completion
        )
    }
    
    func searchRecipes(for searchText: String, completion: @escaping (Result<MealResponse, NetworkError>) -> Void) {
        guard let encodedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            
            completion(.failure(.invalidResponse))
            return
        }
        
        guard let url = URL(string: NetworkConstants.baseURL + "search.php?s=\(encodedSearchText)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        networkManager.request(
            url: url,
            method: .GET,
            completion: completion
        )
    }
    
    

        
}

