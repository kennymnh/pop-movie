

import Foundation

struct People: Codable, Identifiable {
    let id: Int
    let known_for_department: String
    let name: String
    let profile_path: String
//    let known_for: [FilmRef]
}

//struct FilmRef: Codable {
//    let id: Int
//    let title: String
//    let backdrop_path: String
//}

extension People {
    static let previewPeople: People = People(id:0, known_for_department: "", name: "", profile_path: "")
}
