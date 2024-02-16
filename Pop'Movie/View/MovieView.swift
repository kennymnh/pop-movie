import SwiftUI

struct MovieView: View {
    // MARK: PROPERTIES
    let movieId: Int
    let genres = ["Science-fiction", "Animation"];
    
    @StateObject var movieModel = MovieModel()
    
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
                    .font(.largeTitle.bold())
                
                Text("\(movieModel.movie.getFormattedRuntime())  |  \(movieModel.movie.getFormattedDate())")
                    .opacity(0.4)
                    .padding(.top, 8)
                
                HStack {
                    ForEach(movieModel.movie.genres) { genre in
                        Text(genre.name)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 4)
                            .background(.black.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                    }
                }
                .padding(.vertical)
                
                RatingComponentView(rating: movieModel.movie.voteAverage / 2, ratingMax: 5)
                    .padding(.top, 8)
                
                
                // MARK: Overview
                
                Text("Synopsis")
                    .font(.title.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 48)
                
                Text(movieModel.movie.overview)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
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
                    }
                }
            }
        }
        .task {
            print("task triggered")
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
