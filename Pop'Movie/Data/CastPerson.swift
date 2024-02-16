import Foundation

struct CastPerson: Codable, Identifiable {
    let id: Int
    
    let name: String
    
    let department: String
    let character: String?
    
    let profilePicture: String?
}


extension CastPerson {
    static let previewActor: CastPerson = CastPerson(id: 0, name: "", department: "", character: "", profilePicture: "")
    static let previewNonActor: CastPerson = CastPerson(id: 0, name: "", department: "", character: nil, profilePicture: "")
}
