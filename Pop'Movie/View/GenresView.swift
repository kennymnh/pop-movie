import SwiftUI

struct GenresView: View {
    // MARK: PROPERTIES
    @StateObject var genreModel = GenresModel()
    @State private var firstLoad = true
    
    
    // MARK: BODY
    var body: some View {
        VStack {
            List {
                HStack {
                    Text("Catégories")
                        .font(.largeTitle.bold())
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 8)
                }
                
                ForEach(genreModel.genres) { genre in
                    // MARK: Category Nav Link
                    NavigationLink(destination: MovieByGenreView(genreId: genre.id, title: genre.name)) {
                        HStack {
                            Text(genre.name)
                                .font(.title3.bold())
                                .padding(.vertical, 8)
                        }
                    }
                }
            }
            .navigationTitle("Catégories")
        }
        // MARK: First load
        .task {
            if (firstLoad) {
                await genreModel.fetchData()
                firstLoad = false
            }
        }
    }
}

// MARK: PREVIEW
#Preview {
    GenresView()
}
