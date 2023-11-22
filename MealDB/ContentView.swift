//
//  ContentView.swift
//  MealDB
//  Created by Zaid Naing on 11/17/23.
//

import SwiftUI

struct ContentView: View {
    @State private var meals = [MealCategoryModel]()
    //By Default, the list is sorted alphabetically
    @State private var selectedSortOption: SortOption = .alphabetical
    
    //Enum and switch case for sorting menu
    enum SortOption {
            case alphabetical
            case byID
    }
    var sortedMeals: [MealCategoryModel] {
            switch selectedSortOption {
            case .alphabetical:
                return meals.sorted { $0.strMeal < $1.strMeal }
            case .byID:
                return meals.sorted { $0.idMeal < $1.idMeal }
            }
    }
    
    var body: some View {
        NavigationStack{
            ZStack {
                AnimatedBackground()
                VStack{
                    List(sortedMeals, id: \.idMeal){ meal in
                        NavigationLink{
                            DetailView(selectedMeal: meal)
                        }label: {
                            HStack{
                                VStack(alignment: .leading){
                                    Text(meal.strMeal).font(.title3).bold()
                                    Text(meal.idMeal)
                                }
                                Spacer()
                                AsyncImage(url: URL(string: meal.strMealThumb )){ phase in
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
                                .frame(width: 100, height: 100)
                                .clipShape(.rect(cornerRadius: 10))
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Desserts")
            .toolbar(content: {
                //Navigates to SettingsView()
                ToolbarItem(placement: .topBarLeading){
                    NavigationLink(destination: SettingsView()){
                        Image(systemName: "gear")
                            .foregroundStyle(Color.primary)
                            .bold()
                    }
                }
                
                //Bar menu that lets the user choose between .alphabetical and .byID
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: {
                            selectedSortOption = .alphabetical
                        }) {
                            Label("Sort Alphabetically", systemImage: "textformat.abc")
                        }
                        
                        Button(action: {
                            selectedSortOption = .byID
                        }) {
                            Label("Sort By ID", systemImage: "number")
                        }
                    } label: {
                        Image(systemName: "arrow.up.arrow.down.circle")
                            .foregroundStyle(Color.primary)
                            .bold()
                    }
                }
                
            })
            
        }
        .task {
            await fetchDeserts()
        }
        
    }
    
    //fetchDeserts performs a networking call to populate the list of Deserts
    //It includes name, id and image link, all as strings
    func fetchDeserts() async {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")else{
            return
        }
        
        do{
            let (data,_) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(MealsCategoryResponse.self, from: data)
            {
                meals = decodedResponse.meals
            }
        }catch {
            print("Invalid data")
        }
    }
    
}

#Preview {
    ContentView()
}
