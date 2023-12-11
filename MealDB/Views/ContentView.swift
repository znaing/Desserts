//  ContentView.swift
//  MealDB
//  Created by Zaid Naing on 11/17/23.

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack {
                AnimatedBackground()
                VStack {
                    List(viewModel.sortedMeals) { meal in
                        NavigationLink{
                            DetailView(selectedMeal: meal)
                        }label: {
                            HStack {
                                VStack(alignment: .leading){
                                    Text(meal.strMeal).font(.title3).bold()
                                    Text(meal.idMeal)
                                }
                                Spacer()
                                MealThumbNail(imageString: meal.strMealThumb)
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Desserts")
            .toolbar(content: {
                //Navigates to SettingsView()
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                            .foregroundStyle(Color.primary)
                            .bold()
                    }
                }
                //Bar menu that lets the user choose between .alphabetical and .byID
                ToolbarItem(placement: .navigationBarTrailing) {
                    SortMenu(selectedSortOption: $viewModel.selectedSortOption)
                }
            })
        }
        .task {
            await viewModel.fetchDeserts()
        }
    }
}

struct MealThumbNail: View {
    let imageString: String
    var body: some View {
        AsyncImage(url: URL(string: imageString )){ phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            }else if phase.error != nil {
                Text("There was an error loading the image")
            }else{
                ProgressView()
            }
        }
        .frame(width: 100, height: 100)
        .clipShape(.rect(cornerRadius: 10))
    }
}

struct SortMenu: View {
    @Binding var selectedSortOption: ContentViewModel.SortOption
    var body: some View {
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
}
#Preview {
    ContentView()
}
