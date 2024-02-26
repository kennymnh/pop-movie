import SwiftUI

struct MainView: View {
    // MARK: PROPERTIES
    
    
    
    // MARK: BODY
    var body: some View {
        NavigationStack {
            TabView {
                MovieByGenreView(genreId: 0, title: "Tendances").tabItem {
                    Image(systemName: "sparkles.tv")
                    Text("Découverte")
                }
                
                GenresView().tabItem {
                    Image(systemName: "square.grid.3x2.fill")
                    Text("Catégories")
                }
                
                SearchView().tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Recherche")
                }
            }
            .background(ignoresSafeAreaEdges: .all)

        }
    }
}

// MARK: PREVIEW
#Preview {
    MainView()
}

