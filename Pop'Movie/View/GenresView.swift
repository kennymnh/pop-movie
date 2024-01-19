//
//  CategoriesView.swift
//  Pop'Movie
//
//  Created by SDV Bordeaux on 19/01/2024.
//

import SwiftUI

struct GenresView: View {
    // MARK: PROPERTIES
    @StateObject var genreModel = GenresModel()
    @State private var searchText = ""
    
    // MARK: BODY
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Rechercher une catégorie", text: $searchText)
                    .padding(7)
//                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                
                List {
                    ForEach(genreModel.genres.filter { genre in
                        searchText.isEmpty || genre.name.localizedCaseInsensitiveContains(searchText)}) { genre in
                            NavigationLink(destination: HomeView()) {
                                HStack {
                                    Text(genre.name)
                                        .font(.title2.bold())
                                        .padding(.vertical)
                                }
                                
                        }
                    }
                }
                .navigationTitle("Catégories")
            }
            
        }
        .task {
            await genreModel.fetchData()
        }
    }
}

// MARK: PREVIEW
#Preview {
    GenresView()
}
