import SwiftUI

struct MovieByGenreView: View {
    // MARK: PROPERTIES
    let genreId: Int
    let title: String
    
    @StateObject private var partialMovieModel = PartialMoviesModel()
    @State private var isLoadingMore = false
    @State private var currentPage = 1
    
    @State private var selectedPartialMovie: PartialMovie? = nil
    
    var body: some View {
        ScrollView {
            VStack {
                Text(title)
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 100)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 30) {
                    
                    ForEach(partialMovieModel.partialMovies) { partialMovie in
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
                        .onAppear {
                            if !isLoadingMore && partialMovie.id == partialMovieModel.partialMovies.last?.id {
                                isLoadingMore = true
                                
                                Task {
                                    await partialMovieModel.fetchData(page: currentPage + 1)
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
            await partialMovieModel.fetchData(genre: genreId)
        }
        .sheet(item: $selectedPartialMovie) { partialMovie in
            MovieSheetView(partialMovie: partialMovie)
                .presentationDetents([.medium, .large])
        }
    }
}



// MARK: PREVIEW
#Preview {
    MovieByGenreView(genreId: 0, title: "Preview")
}
