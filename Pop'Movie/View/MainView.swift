import SwiftUI

struct MainView: View {
    // MARK: PROPERTIES
    
    
    
    // MARK: BODY
    var body: some View {
        NavigationStack {
            TabView {
                MovieByGenreView(genreId: 0, title: "Tendances").tabItem {
                    Image(systemName: "movieclapper.fill")
                    Text("Tendances")
                }
                
                GenresView().tabItem {
                    Image(systemName: "list.dash")
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

