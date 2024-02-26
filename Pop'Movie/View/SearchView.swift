import SwiftUI
import Combine

struct SearchView: View {
    @StateObject private var movieSearchModel = MovieSearchModel()
    @State private var searchText: String = ""
    @State private var debounceTimer: AnyCancellable?
    
    var body: some View {
        NavigationView {
            List(movieSearchModel.results) { movie in
                HStack {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500" + movie.poster_path), content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 100)
                    }, placeholder: {
                        ProgressView()
                    })
                    Text(movie.title)
                }
            }.listStyle(.plain)
                .searchable(text: $searchText, prompt: "Saisissez un titre ou des mots-clés")
                .onChange(of: searchText) {
                    debounceTimer?.cancel() // Annule le timer précédent
                    debounceTimer = Just(searchText)
                        .delay(for: .milliseconds(600), scheduler: RunLoop.main)
                        .sink { _ in
                            Task {
                                if !searchText.isEmpty && searchText.count > 3 {
                                    print("new searchText is \(searchText)")
                                    await movieSearchModel.fetchData(query: searchText)
                                } else {
                                    movieSearchModel.results.removeAll()
                                }
                            }
                        }
                }
            
                .navigationTitle("Recherche")
        }
    }
}

#Preview {
    SearchView()
}
