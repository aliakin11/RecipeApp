//
//  SettingsViewModel.swift
//  RecipeApp
//
//  Created by Ali AKIN on 3.07.2025.
//

import Foundation


class SettingsViewModel {
    var sections = SettingsSection.sections
    
    private var themeMode: Int = 0
    
}

extension SettingsViewModel {
    func fetchThemeMode() -> Int {
        let themeMode = UserDefaults.standard.integer(forKey: "themeMode")
        return themeMode
    }
}
