//
//  ContentView.swift
//  Pop'Movie
//
//  Created by SDV Bordeaux on 18/01/2024.
//

import SwiftUI

struct MainView: View {
    // MARK: PROPERTIES
    
    
    
    // MARK: BODY
    var body: some View {
        
        TabView {
            MovieByGenreView(genreId: 0, title: "Tendances").tabItem {
                Image(systemName: "movieclapper.fill")
                Text("Tendances")
            }
            
            GenresView().tabItem {
                Image(systemName: "list.dash")
                Text("Catégories")
            }
            
            Text("Recherche").tabItem {
                Image(systemName: "magnifyingglass")
                Text("Recherche")
            }
        }
        .background(ignoresSafeAreaEdges: .all)
        
        
    }
}

// MARK: PREVIEW
#Preview {
    MainView()
}

