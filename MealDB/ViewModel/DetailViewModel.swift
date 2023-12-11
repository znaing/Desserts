//  DetailViewModel.swift
//  MealDB
//  Created by Zaid Naing on 12/8/23.

import Foundation

class DetailViewModel: ObservableObject {
    
    @Published var mealDetails : MealDetailsModel?

    //FetchDetails function takes id number from selected meal and performs an API call to get details of the selected meal
    //Decoded data gets stored in mealDetails that has more attributes such as instructions, ingredients and measurements
    func fetchMealDetails(selectedMeal: MealCategoryModel) async {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(selectedMeal.idMeal)")else{
            return
        }
        
        do {
            let (data,_) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(MealsDetailsResponse.self, from: data) {
                if let meal = decodedResponse.meals.first{
                    await MainActor.run{
                        mealDetails = meal
                    }
                }else{
                    print("Error")
                }
            }
        } catch {
            print("Invalid data")
        }
    }
}
