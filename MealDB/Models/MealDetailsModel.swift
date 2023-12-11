//
//  MealDetailsModel.swift
//  MealDB
//
//  Created by Zaid Naing on 12/11/23.
//

import Foundation
//For meal details
struct MealsDetailsResponse: Codable {
    let meals : [MealDetailsModel]
}

struct MealDetailsModel: Codable {
    let strMeal: String
    let idMeal: String
    let strMealThumb: String
    let strInstructions: String
    
    let strIngredient1: String
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    
    //Puts all strings with strIngredients text into an array so its easier to display
    var ingredients: [String?] {
            let mirror = Mirror(reflecting: self)
            return mirror.children.compactMap { (label, value) in
                // Check if the label starts with "strIngredient" and the value is a String
                if let label = label, label.hasPrefix("strIngredient"), let ingredient = value as? String {
                    return ingredient
                }
                return nil
            }
    }
    
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    
    //Same as ingredients, Measurements are also put into an array
    var measurements: [String?] {
            let mirror = Mirror(reflecting: self)
            return mirror.children.compactMap { (label, value) in
                // Check if the label starts with "strIngredient" and the value is a String
                if let label = label, label.hasPrefix("strMeasure"), let ingredient = value as? String {
                    return ingredient
                }
                return nil
            }
    }
}
