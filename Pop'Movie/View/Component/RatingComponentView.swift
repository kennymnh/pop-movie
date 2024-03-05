import SwiftUI

// Composant qui permet de faire des étoiles de notation
// Principe :
// On calcule le nombre de d'étoiles pleines
// ainsi que celles vides
struct RatingComponentView: View {
    let rating: Float
    let ratingMax: Int
    
    init(rating: Float, ratingMax: Int) {
        self.rating = rating
        self.ratingMax = ratingMax
    }
    
    var body: some View {
        HStack {
            ForEach(1...ratingMax, id: \.self) { index in
                Image(systemName: self.imageName(for: index))
                    .foregroundColor(self.starColor(for: index))
            }
        }
    }
    
    private func imageName(for index: Int) -> String {
        if Float(index) <= rating {
            return "star.fill"
        } else if Float(index - 1) < rating && rating < Float(index) {
            return "star.leadinghalf.fill"
        } else {
            return "star"
        }
    }
    
    private func starColor(for index: Int) -> Color {
        if Float(index - 1) <= rating {
            return .yellow
        } else {
            return .gray
        }
    }
}

#Preview {
    RatingComponentView(rating: 2.5, ratingMax: 5)
}
