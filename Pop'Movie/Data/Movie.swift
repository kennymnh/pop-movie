import Foundation

struct Movie: Codable, Identifiable {
    let id: Int
    
    let title: String
    let overview: String
    let runtime: Int
    let releaseDate: String
    let status: String
    
    let popularity: Float
    let voteAverage: Float
    let voteCount: Int
    
    let adult: Bool
    let genres: [Genre]
    
    let backdropPath: String
    let posterPath: String
    
    let countries: [String]
    let productionCompanies: [String]
    let spokenLanguages: [String]
    let budget: Int
    
    func getFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: releaseDate) else {
            return "Invalid Date"
        }
        
        dateFormatter.dateFormat = "dd MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "fr_FR")
        return dateFormatter.string(from: date)
    }
    
    func getFormattedRuntime() -> String {
        let hours = runtime / 60
        let minutes = runtime % 60
        
        return "\(hours)h \(minutes)m"
    }
}


extension Movie {
    static let previewMovie: Movie = Movie(id: 0, title: "...", overview: "", runtime: 0, releaseDate: "2000-01-01", status: "", popularity: 0, voteAverage: 10, voteCount: 0, adult: false, genres: [], backdropPath: "", posterPath: "", countries: [], productionCompanies: [], spokenLanguages: [], budget: 0)
}
