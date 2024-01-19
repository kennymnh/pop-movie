import Foundation

class GenreModel: ObservableObject {
    @Published var genres = [Genre]()
    
    func fetchData() async {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5NjRhNDU0ODRjNGE4MDAyMmMyNWQyODBhNDc0MTQzOSIsInN1YiI6IjY1YTdlODc3NTFjMDFmMDEyYjYwYzI0NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.m0tbhORYqDObIQi1uABFmBipAMpcoqsJL9zc0gVQhQQ"
        ]
        
        guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?language=fr") else {
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
                   let results = json["genres"] as? [[String: Any]] {
                    
                    for result in results {
                        if let id = result["id"] as? Int,
                            let name = result["name"] as? String {
                            
                            let genre = Genre(id: id, name: name)
                            self.genres.append(genre)
                            
                            print(genre)
                        }
                    }
                }
                
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
