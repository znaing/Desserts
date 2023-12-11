//
//  FetchMeal.swift
//  MealDB
//  Created by Zaid Naing on 12/8/23.

import Foundation
class ContentViewModel: ObservableObject {
    
    @Published var meals = [MealCategoryModel]()
    
    //By Default, the list is sorted alphabetically
    @Published var selectedSortOption: SortOption = .alphabetical
    
    //Enum and switch case for sorting menu
    enum SortOption {
            case alphabetical
            case byID
    }
    
    ///Sorting Option for desert  list
    var sortedMeals: [MealCategoryModel] {
            switch selectedSortOption {
            case .alphabetical:
                return meals.sorted { $0.strMeal < $1.strMeal }
            case .byID:
                return meals.sorted { $0.idMeal < $1.idMeal }
            }
    }
    
    ///fetchDeserts performs a networking call to populate the list of Deserts
    ///It includes name, id and image link, all as strings
    func fetchDeserts() async {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")else{
            return
        }
        
        do{
            let (data,_) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(MealsCategoryResponse.self, from: data) {
                await MainActor.run{
                    meals = decodedResponse.meals
                }
            }
        }catch {
            print("Invalid data")
        }
    }
}
