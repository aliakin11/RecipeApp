//
//  FavoriteViewModel.swift
//  RecipeApp
//
//  Created by Ali AKIN on 10.07.2025.
//
import Foundation

final class FavoritesViewModel {
    
    weak var output: FavoritesViewModelOutput?
    private let coreDataManager: CoreDataManagerProtocol

    private(set) var favoriteMeals: [Meal] = []

    init(coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }

    func fetchFavorites() {
        favoriteMeals = coreDataManager.fetchFavorites()
        
        if favoriteMeals.isEmpty {
            output?.showEmptyState(message: "No Favorites Yet")
        } else {
            output?.updateFavoritesList()
        }
    }
}
