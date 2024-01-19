import SwiftUI

struct GenreView: View {
    // MARK: PROPERTIES
    @StateObject var partialMovieModel = PartialMoviesModel()
    let genreId: Int
    
    
    // MARK: BODY
    var body: some View {
        
        NavigationStack {
            
        }
        .task {
            await partialMovieModel.fetchData(genre: genreId)
        }
    }
}

// MARK: PREVIEW
#Preview {
    GenreView(genreId: 22)
}
