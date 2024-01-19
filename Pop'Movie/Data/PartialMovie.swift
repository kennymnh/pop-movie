import Foundation

struct PartialMovie: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let release_date: String
    let poster_path: String
}

extension PartialMovie {
    static let previewPartialMovie: PartialMovie = PartialMovie(id: 0, title: "", overview: "", release_date: "", poster_path: "")
}
