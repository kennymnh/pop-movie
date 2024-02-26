import Foundation

struct Genre: Codable, Identifiable {
    let id: Int
    let name: String
}

extension Genre {
    static let previewGenre = Genre(id: 0, name: "")
}

extension [Genre] {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
