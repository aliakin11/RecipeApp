//
//  NetworkError.swift
//  RecipeApp
//
//  Created by Ali AKIN on 1.07.2025.
//

import Foundation

enum NetworkError: Error {
    
    case invalidURL
    case decodingError
    case invalidResponse
    case invalidData
    case requestFailedWith(Int)
    case customError(Error)
    
    var localizedDescription: String {
        
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .decodingError:
            return "Failed to decode response."
        case .invalidResponse:
            return "Invalid response."
        case .invalidData:
            return "Received invalid data."
        case .requestFailedWith(let statusCode):
            return "Request failed with status code \(statusCode)."
        case .customError(let error):
            return "An error occurred: \(error.localizedDescription)"
        }
        
    }
}
