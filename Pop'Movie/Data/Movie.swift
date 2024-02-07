import Foundation

struct Movie: Codable, Identifiable {
    let id: Int
    
    // MARK: MAIN INFORMATION
    
    let title: String
    let overview: String
    let releaseDate: Date
    let status: String
    
    let popularity: Float
    let voteAverage: Float
    let voteCount: Int
    
    let adult: Bool
    let genres: [Genre]
    
    let backdropPath: String
    let posterPath: String
    
    // MARK: MORE INFORMATION
    
    let countries: [String]
    let productionCompanies: [String]
    let spokenLanguages: [String]
    let budget: Int
}
