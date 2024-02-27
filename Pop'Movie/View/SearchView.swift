import SwiftUI
import Combine

struct SearchView: View {
    @StateObject private var movieSearchModel = MovieSearchModel()
    @State private var searchText: String = ""
    @State private var debounceTimer: AnyCancellable?
    
    var body: some View {
        NavigationView {
            List(movieSearchModel.results) { movie in
                NavigationLink(destination: MovieView(movieId: movie.id)) {
                    HStack {
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500" + movie.poster_path)) { image in
                            image
                                .resizable()
                                .aspectRatio(2/3, contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        } placeholder: {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.gray)
                                    .opacity(0.1)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .aspectRatio(2/3, contentMode: .fill)
                                
                                ProgressView()
                            }
                        }
                        .frame(width: 100)
                        
                        VStack {
                            Text(movie.title)
                                .font(.title3.bold())
                        }
                        .padding(.horizontal, 6)
                    }
                }
            }
            .listStyle(.plain)
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
