import SwiftUI

struct MovieByGenreView: View {
    // MARK: PROPERTIES
    let genreId: Int
    let title: String
    
    @StateObject private var movieListingModel = MovieListingModel()
    @State private var firstLoad = true
    @State private var isLoadingMore = false
    @State private var currentPage = 1
    
    @State private var selectedPartialMovie: PartialMovie? = nil
    @State private var navigateToMovieView = false
    @State private var navigateToMovieId = 0
    
    // MARK: BODY
    var body: some View {
        ScrollView {
            VStack {
                Text(title)
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 100)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 30) {
                    
                    ForEach(movieListingModel.partialMovies) { partialMovie in
                        VStack(alignment: .leading) {
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500" + partialMovie.poster_path)) { image in
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
                            
                            Text(partialMovie.title)
                                .font(.title3.bold())
                                .lineLimit(1)
                                .padding(.leading, 3)
                        }
                        .padding(.horizontal, 8)
                        .onTapGesture {
                            selectedPartialMovie = partialMovie
                        }
                        // MARK: Infinite Scrolling
                        .onAppear {
                            // Si c'est pas déjà en train de charger et que on est à la fin de la liste, on charge le reste
                            if !isLoadingMore && partialMovie.id == movieListingModel.partialMovies.last?.id {
                                isLoadingMore = true
                                
                                Task {
                                    await movieListingModel.fetchData(page: currentPage + 1)
                                    currentPage += 1
                                    isLoadingMore = false
                                }
                                
                            }
                        }
                    }
                }
                .padding()
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        .ignoresSafeArea(edges: .top)
        .task {
            // MARK: First load
            // Empêche un nouveau chargement lorsque l'on vient d'une autre view en passant par la TabView
            if (firstLoad) {
                await movieListingModel.fetchData(genre: genreId)
                firstLoad = false
            }
        }
        // MARK: Bottom Sheet
        .sheet(item: $selectedPartialMovie) { partialMovie in
            MovieSheetView(partialMovie: partialMovie) { movieId in
                selectedPartialMovie = nil
                navigateToMovieId = movieId
                navigateToMovieView = true
            }
            .presentationDetents([.medium, .large])
        }
        .background {
            NavigationLink(destination: MovieView(movieId: navigateToMovieId), isActive: $navigateToMovieView) { EmptyView() }
        }
    }
}



// MARK: PREVIEW
#Preview {
    MovieByGenreView(genreId: 0, title: "Preview")
}
