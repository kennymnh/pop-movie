import SwiftUI

struct MovieSheetView: View {
    // MARK: PROPERTIES
    @State var partialMovie: PartialMovie
    
    // Closure to dismiss sheet and navigate
    let dismissAndShowMovieInfo: (Int) -> Void
    
    // MARK: BODY
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    // MARK: Image poster
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
                                .aspectRatio(2/3, contentMode: .fit)
                            
                            ProgressView()
                        }
                    }
                    
                    // MARK: Title, release and score
                    VStack(alignment: .leading) {
                        Text(partialMovie.title)
                            .font(.title.bold())
                            .padding(.bottom)
                        
                        Text("Sorti le " + partialMovie.release_date)
                            .font(.headline)
                            .opacity(0.6)
                            .padding(.bottom, 8)
                        
                        RatingComponentView(rating: partialMovie.vote_average / 2, ratingMax: 5)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 8)
                    
                    Spacer()
                }
                .frame(height: 150)
                .padding(.bottom)
                
                Text(partialMovie.overview)
                    .padding(.bottom)
                
                // MARK: More info button
                Button(action: {
                    // Call the closure when the button is tapped
                    dismissAndShowMovieInfo(partialMovie.id)
                }) {
                    Text("Plus d'informations")
                        .font(.callout.bold())
                        .frame(minWidth: UIScreen.main.bounds.width - 90)
                        .padding()
                }
                .foregroundColor(.white)
                .background(Color.blue.opacity(0.9))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Spacer()
            }
            .padding(30)
        }
    }
}

// MARK: PREVIEW
// #Preview {
//     MovieSheetView(id: 69)
// }
