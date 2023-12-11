//  DetailView.swift
//  MealDB
//  Created by Zaid Naing on 11/17/23.

import SwiftUI
///selected meal details from the list from ContentView()
struct DetailView: View {
    @StateObject private var viewModel = DetailViewModel()
    let selectedMeal : MealCategoryModel
    var body: some View {
        NavigationStack{
            ZStack{
                AnimatedBackground()
                ScrollView {
                    VStack {
                        if let mealDetails = viewModel.mealDetails{
                            MealTitleView(title: mealDetails.strMeal)
                            MealImageView(imageString: mealDetails.strMealThumb)
                            ZStack {
                                Color.theme.clipShape(.rect(cornerRadius: 10))
                                VStack{
                                    InstructionsView(instructions: mealDetails.strInstructions)
                                    IngredientsView(ingredients: mealDetails.ingredients, measurements: mealDetails.measurements)
                                }
                            }
                            .foregroundStyle(Color.themeOfText)
                            .padding()
                        }
                    }
                }
            }
        }
        .task {
            await viewModel.fetchMealDetails(selectedMeal: selectedMeal)
        }
    }
}

///Meal Title
struct MealTitleView: View {
    let title : String
    var body: some View {
        Text(title)
            .font(.title)
            .bold()
            .padding()
    }
}

///Meal Image
struct MealImageView: View {
    let imageString : String
    var body: some View {
        //Retrieving Dessert image with Async image with error handling and loading icon
        AsyncImage(url: URL(string: imageString )){ phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            }else if phase.error != nil {
                Text("There was an error loading the image")
            }else {
                ProgressView()
            }
        }
        .frame(width:300, height:300)
        .border(Color.black, width: 1)
        .clipShape(.rect(cornerRadius: 10))
    }
}

///Instructions for meal
struct InstructionsView: View {
    let instructions : String
    var body: some View {
        VStack {
            HStack {
                Text("Instructions")
                    .font(.title2).bold()
                    .multilineTextAlignment(.leading)
                    .padding()
                Spacer()
            }
            
            Text(instructions)
                .font(.body)
                .padding(.horizontal)
        }
        
    }
}

///List of ingredients and measurements
struct IngredientsView: View {
    let ingredients: [String?]
    let measurements: [String?]
    
    var body: some View {
        Text("Ingredients and Measurement")
            .font(.title2).bold()
            .padding()
        
        VStack(alignment: .leading) {
            ForEach(ingredients.indices, id: \.self) { index in
                HStack(){
                    if let ingredient = ingredients[index], ingredient != ""{
                        Text(ingredient)
                    }
                    Spacer()
                    if let measure = measurements[index], measure != ""{
                        Text(measure)
                    }
                }
            }
        }
        .padding(.horizontal,50)
        
    }
}
