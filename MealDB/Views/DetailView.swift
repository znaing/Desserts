//  DetailView.swift
//  MealDB
//  Created by Zaid Naing on 11/17/23.

import SwiftUI

struct DetailView: View {
    //selected meal from the list from ContentView()
    let selectedMeal : MealCategoryModel
    @State private var mealDetails : MealDetailsModel?
    
    var body: some View {
        NavigationStack{
            ZStack{
                AnimatedBackground()
                ScrollView{
                    VStack{
                        if let mealDetails = mealDetails{
                            Text(mealDetails.strMeal)
                                .font(.title)
                                .bold()
                                .padding()
                            
                            //Retrieving Dessert image with Async image with error handling and loading icon
                            AsyncImage(url: URL(string: mealDetails.strMealThumb )){ phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFit()
                                }else if phase.error != nil{
                                    Text("There was an error loading the image")
                                }else{
                                    ProgressView()
                                }
                            }
                            .frame(width:300, height:300)
                            .border(Color.black, width: 1)
                            .clipShape(.rect(cornerRadius: 10))
                            
                            ZStack{
                                Color.theme
                                    .clipShape(.rect(cornerRadius: 10))
                                VStack{
                                    HStack{
                                        Text("Instructions")
                                            .font(.title2).bold()
                                            .multilineTextAlignment(.leading)
                                            .padding()
                                        Spacer()
                                    }
                                    
                                    Text(mealDetails.strInstructions)
                                        .font(.body)
                                        .padding(.horizontal)
                                    
                                    Text("Ingredients and Measurement")
                                        .font(.title2).bold()
                                        .padding()
                                    
                                    VStack(alignment: .leading){
                                        ForEach(mealDetails.ingredients.indices, id: \.self) { index in
                                            HStack(){
                                                if let ingredient = mealDetails.ingredients[index]{
                                                    if mealDetails.ingredients[index] != "" {
                                                        Text(ingredient)
                                                    }
                                                }
                                                Spacer()
                                                if let measure = mealDetails.measurements[index]{
                                                    if mealDetails.measurements[index] != "" {
                                                        Text(measure)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .padding(.horizontal,50)
                                }
                                .foregroundStyle(Color.themeOfText) // you could use `.primary` or not set it at all, because the color of the text will automatically change
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .task {
            await fetchMealDetails()
        }
    }
    
    // This could be moved into a "viewModel" and / or outside of the view, so that it can be unit tested
    
    //FetchDetails function takes id number from selected meal and performs an API call to get details of the selected meal
    //Decoded data gets stored in mealDetails that has more attributes such as instructions, ingredients and measurements
    func fetchMealDetails() async {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(selectedMeal.idMeal)")else{
            return
        }
        
        do{
            let (data,_) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(MealsDetailsResponse.self, from: data)
            {
                if let meal = decodedResponse.meals.first{
                    mealDetails = meal
                }else{
                    print("Error")
                }
            }
        }catch {
            print("Invalid data")
        }
    }
    
}
