//
//  PeopleModel.swift
//  Pop'Movie
//
//  Created by SDV Bordeaux on 19/01/2024.
//

import Foundation

class PeopleModel: ObservableObject {
    @Published var peoples = [People]()
    
    func fetchData(page: Int = 1) async {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5NjRhNDU0ODRjNGE4MDAyMmMyNWQyODBhNDc0MTQzOSIsInN1YiI6IjY1YTdlODc3NTFjMDFmMDEyYjYwYzI0NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.m0tbhORYqDObIQi1uABFmBipAMpcoqsJL9zc0gVQhQQ"
        ]
        
        guard let url = URL(string: "https://api.themoviedb.org/3/person/popular?language=fr&page=\(page)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let results = json["results"] as? [[String: Any]] {
                    
                    for result in results {
                        if let id = result["id"] as? Int,
                            let known_for_department = result["known_for_department"] as? String,
                            let name = result["name"] as? String,
                            let profile_path = result["profile_path"] as? String {
                            
                            let people = People(id: id, known_for_department: known_for_department, name: name, profile_path: profile_path)
                            self.peoples.append(people)
                        }
                    }
                }
                
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
