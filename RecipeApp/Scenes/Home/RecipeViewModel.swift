//
//  RecipeViewModel.swift
//  RecipeApp
//
//  Created by Ali AKIN on 2.07.2025.
//

import Foundation

final class RecipeViewModel {
    
    // MARK: - Properties
    private let recipeService: RecipeServiceProtocol
    weak var delegate: RecipeViewControllerProtocol?
    
    private(set) var categories: [Category] = []
    private(set) var meals: [Meal] = []
    
    init(recipeService: RecipeServiceProtocol = RecipeService()) {
        self.recipeService = recipeService
    }
}

// MARK: - Methods
extension RecipeViewModel {
    
    func fetchCategories() {
        recipeService.fetchCategories { [weak self] result in
            switch result {
            case .success(let success):
                self?.categories = success.categories
                self?.delegate?.reloadCollectionView()
                
                let firstCategory = success.categories.first?.strCategory ?? ""
                self?.fetchRecipes(for: firstCategory)
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchRecipes(for category: String) {
        recipeService.fetchRecipes(for: category) { [weak self] result in
            switch result {
            case .success(let success):
                self?.meals = success.meals
                self?.delegate?.reloadTableView()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func searchRecipes(for keyword: String) {
        recipeService.fetchRecipes(for: keyword) { [weak self] result in
            switch result {
            case .success(let success):
                self?.meals = success.meals
                self?.delegate?.reloadTableView()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    
}
