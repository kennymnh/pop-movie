import SwiftUI

struct MovieView: View {
    // MARK: PROPERTIES
    let movieId: Int
    
    @StateObject var movieModel = MovieModel()
    @State private var selectedActor: CastPerson? = nil
    
    // MARK: BODY
    var body: some View {
        ScrollView() {
            
            
            // MARK: Cover
            
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original" + movieModel.movie.posterPath)) { image in
                image
                    .resizable()
            } placeholder: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.gray)
                        .opacity(0.2)
                    
                    ProgressView()
                }
            }
            .aspectRatio(2/3, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal)
            
            
            // MARK: Title & meta
            
            VStack(spacing: 0) {
                Text(movieModel.movie.title)
                    .multilineTextAlignment(.center)
                    .font(.largeTitle.bold())
                
                Text("\(movieModel.movie.getFormattedRuntime())  |  \(movieModel.movie.getFormattedDate())")
                    .opacity(0.4)
                    .padding(.top, 8)
                
                VStack(alignment: .center, spacing: 8) {
                    ForEach(0..<movieModel.movie.genres.count, id: \.self) { index in
                        if index % 3 == 0 {
                            HStack(spacing: 8) {
                                ForEach(0..<min(3, movieModel.movie.genres.count - index), id: \.self) { innerIndex in
                                    let genre = movieModel.movie.genres[index + innerIndex]
                                    
                                    Text(genre.name)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 4)
                                        .background(.black.opacity(0.1))
                                        .clipShape(RoundedRectangle(cornerRadius: 25))
                                }
                            }
                        }
                    }
                }
                .padding()
                
                // MARK: Rating
                RatingComponentView(rating: movieModel.movie.voteAverage / 2, ratingMax: 5)
                    .padding(.top, 8)
                
                
                // MARK: Overview
                
                Text("Synopsis")
                    .font(.title.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 48)
                
                if (movieModel.movie.overview == "") {
                    Text("Le synopsis pour ce film n'est pas disponible.")
                        .italic()
                        .foregroundStyle(.opacity(0.5))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                } else {
                    Text(movieModel.movie.overview)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 12)
            .padding(.horizontal, 16)
            
            
            // MARK: Casting
            
            Text("Distribution")
                .font(.title.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 24)
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(movieModel.actors) { actor in
                        ActorCard(actor: actor)
                            .onTapGesture {
                                selectedActor = actor
                            }
                    }
                }
            }
        }
        // MARK: Bottom Sheet
        .sheet(item: $selectedActor) { actor in
            ActorSheetView(actor: actor)
                .presentationDragIndicator(.visible)
                .presentationDetents([.height(200)])
        }
        // MARK: First load
        .task {
            await movieModel.fetchMovieData(movieId: movieId)
            await movieModel.fetchCastData(movieId: movieId)
        }
    }
}

// MARK: ACTOR CARD
struct ActorCard: View {
    let actor: CastPerson
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500" + (actor.profilePicture ?? ""))) { image in
                image.resizable()
            } placeholder: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.gray)
                        .opacity(0.1)
                    
                    if (actor.profilePicture != nil && actor.profilePicture != "") {
                        ProgressView()
                    }
                }
            }
            .aspectRatio(2/3, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack(alignment: .leading) {
                Text(actor.name)
                    .lineLimit(1)
                    .font(.subheadline.bold())
                
                Text(actor.character ?? "")
                    .lineLimit(1)
                    .font(.subheadline)
                    .foregroundStyle(.opacity(0.6))
            }
            .padding(.leading, 3)
        }
        .frame(width: 120)
        .padding(.horizontal, 8)
    }
}

// MARK: PREVIEW
#Preview {
    MovieView(movieId: 76600)
}
