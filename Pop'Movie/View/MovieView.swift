import SwiftUI

struct MovieView: View {
    let movieId: Int
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            Text("Movie Id is \(movieId)")
        }
    }
}

#Preview {
    MovieView(movieId: 76600)
}
