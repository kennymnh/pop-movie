import SwiftUI

struct MovieSheetView: View {
    // MARK: PROPERTIES
    let id: Int
    
    // MARK: BODY
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg")) { image in
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
                
                VStack(alignment: .leading) {
                    Text("Avatar: The Way of the Water")
                        .font(.title.bold())
                        .padding(.bottom)
                    
                    Text("Sorti le 14/12/2022")
                        .font(.caption)
                        .opacity(0.6)
                    
                    Spacer()
                }
                .padding(.horizontal, 8)
                
                Spacer()
            }
            .frame(height: 150)
            .padding(.bottom)
            
            Text("Set more than a decade after the events of the first film, learn the story of the Sully family (Jake, Neytiri, and their kids), the trouble that follows them, the lengths they go to keep each other safe, the battles they fight to stay alive, and the tragedies they endure.")
                .padding(.bottom)
            
            NavigationLink(destination: RatingComponentView()) {
                Text("Plus d'informations")
                    .font(.callout.bold())
                    .frame(minWidth: UIScreen.main.bounds.width - 90)
                    .padding()
            }
            .foregroundColor(.white)
            .background(.blue.opacity(0.9))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Spacer()
        }
        .padding(30)
    }
}

// MARK: PREVIEW
#Preview {
    MovieSheetView(id: 69)
}
