//
//  DetailViewModel.swift
//  RecipeApp
//
//  Created by Ali AKIN on 3.07.2025.
//

import Foundation

final class DetailViewModel {
    
    private let coreDataManager: CoreDataManagerProtocol
    private let recipeService: RecipeServiceProtocol
    private(set) var mealID: String
    private(set) var meal: MealDetail?
    
    weak var delegate: DetailViewControllerProtocol?
    
    init(coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared,recipeService: RecipeServiceProtocol = RecipeService(), mealID: String) {
        
        self.coreDataManager = coreDataManager
        self.recipeService = recipeService
        self.mealID = mealID
    }
    
    func isCurrentMealFavorite() -> Bool {
        return coreDataManager.isFavorite(mealID: self.mealID)
    }
    
    func toggleFavorite() {
        guard let mealDetail = self.meal else { return }
        
        let mealToSave = Meal(
            idMeal: mealDetail.idMeal,
            strMeal: mealDetail.strMeal,
            strMealThumb: mealDetail.strMealThumb
        )
        
        if isCurrentMealFavorite() {
            
            coreDataManager.removeFavorite(mealID: self.mealID)
        } else {
            coreDataManager.addFavorite(meal: mealToSave)
        }
        
    }
    
    
    func fetchMealDetails() {
        recipeService.fetchMealDetails(for: mealID) { [weak self] result in
            switch result {
            case .success(let success):
                self?.meal = success.meals.first
                self?.delegate?.reloadData()
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
        
        
    }
}
