import Foundation

struct Genre: Codable, Identifiable {
    let id: Int
    let name: String
}

extension PartialMovie {
    static let previewGenre = Genre(id: 0, name: "")
}
