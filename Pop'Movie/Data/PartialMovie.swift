import Foundation

struct PartialMovie: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let release_date: String
    let poster_path: String
    let vote_average: Float
}

extension PartialMovie {
    static let previewPartialMovie: PartialMovie = PartialMovie(id: 0, title: "", overview: "", release_date: "", poster_path: "", vote_average: 0)
}
