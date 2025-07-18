//
//  CoreDataManager.swift
//  RecipeApp
//
//  Created by Ali AKIN on 10.07.2025.
//

import CoreData

protocol CoreDataManagerProtocol {
    func addFavorite(meal: Meal)
    func removeFavorite(mealID: String)
    func fetchFavorites() -> [Meal]
    func isFavorite(mealID: String) -> Bool
}

final class CoreDataManager: CoreDataManagerProtocol {
    
    // MARK: - Singleton Instance
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    
    private var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    // MARK: - Initialization
    private init() {
        container = NSPersistentContainer(name: "RecipeAppModel")
        
        container.loadPersistentStores { description, error in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    // MARK: - Core Data Operations
    
    private func saveContext() {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch {
            print("Core Data Save Error: \(error.localizedDescription)")
            context.rollback()
        }
    }
    
    func addFavorite(meal: Meal) {
        
        let favoriteMeal = FavoriteMeal(context: context)
        favoriteMeal.id = meal.idMeal
        favoriteMeal.name = meal.strMeal
        favoriteMeal.imageURL = meal.strMealThumb
        
        saveContext()
    }
    
    func removeFavorite(mealID: String) {
        
        let fetchRequest: NSFetchRequest<FavoriteMeal> = FavoriteMeal.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", mealID)
        
        do {
            let results = try context.fetch(fetchRequest)
            results.forEach { context.delete($0) }
            saveContext()
        }
        
        catch {
            print("Core Data Fetch Error: \(error.localizedDescription)")
            
        }
        
    }
    
    func fetchFavorites() -> [Meal] {
        
        let fetchRequest: NSFetchRequest<FavoriteMeal> = FavoriteMeal.fetchRequest()
        
        do {
            let favoriteMeals = try context.fetch(fetchRequest)
            return favoriteMeals.map { meal in
                Meal(
                    idMeal: meal.id,
                    strMeal: meal.name,
                    strMealThumb: meal.imageURL
                )
            }
        }
        
        catch {
            print("Core Data Fetch Error: \(error.localizedDescription)")
            return []
        }
        
    }
    
    func isFavorite(mealID: String) -> Bool {
        let fetchRequest: NSFetchRequest<FavoriteMeal> = FavoriteMeal.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", mealID)
        
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Core Data Favorite Check Error: \(error.localizedDescription)")
            return false
        }
    }
    
}
    
