import SwiftUI

struct GenresView: View {
    // MARK: PROPERTIES
    @StateObject var genreModel = GenresModel()
    @State private var firstLoad = true
    
    
    // MARK: BODY
    var body: some View {
        VStack {
//            Text("Catégories")
//                .font(.largeTitle.bold())
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.horizontal)
//                .padding(.top, 40)
            
            List {
                HStack {
                    Text("Catégories")
                        .font(.largeTitle.bold())
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 8)
                }
                
                ForEach(genreModel.genres) { genre in
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
