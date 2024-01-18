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
            HomeView().tabItem {
                Image(systemName: "phone.fill")
                Text("a")
            }
            
            Text("world").tabItem {
                Image(systemName: "phone.fill")
                Text("b")
            }
        }
        .background(ignoresSafeAreaEdges: .all)
        
        
    }
}

// MARK: PREVIEW
#Preview {
    MainView()
}

