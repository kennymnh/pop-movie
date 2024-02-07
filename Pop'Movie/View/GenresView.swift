import SwiftUI

struct GenresView: View {
    // MARK: PROPERTIES
    @StateObject var genreModel = GenresModel()
    
    // MARK: BODY
    var body: some View {
        VStack {
            Text("Catégories")
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 40)
            
            List {
                ForEach(genreModel.genres) { genre in
                    NavigationLink(destination: MovieByGenreView(genreId: genre.id, title: genre.name)) {
                        HStack {
                            Text(genre.name)
                                .font(.title2.bold())
                                .padding(.vertical)
                        }
                    }
                }
            }
            .navigationTitle("Catégories")
        }
        .task {
            await genreModel.fetchData()
        }
    }
}

// MARK: PREVIEW
#Preview {
    GenresView()
}
