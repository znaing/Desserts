//  MealDBModel.swift
//  MealDB
//  Created by Zaid Naing on 11/17/23.

import Foundation

//For dessert category
struct MealsCategoryResponse:  Codable {
    let meals : [MealCategoryModel]
}

struct MealCategoryModel: Codable, Identifiable {
    let strMeal: String
    let idMeal: String
    let strMealThumb: String
    var id: String {idMeal}

}



//This struct is Alternate app icons
struct AlternativeAppIcons: Identifiable {
    var id = UUID()
    var appIconName : String
    var scrollIconName : String
}
