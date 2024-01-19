import Foundation

class PartialMoviesModel: ObservableObject {
    @Published var partialMovies = [PartialMovie]()
    
    func fetchData(page: Int = 1, genre: Int = 0) async {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5NjRhNDU0ODRjNGE4MDAyMmMyNWQyODBhNDc0MTQzOSIsInN1YiI6IjY1YTdlODc3NTFjMDFmMDEyYjYwYzI0NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.m0tbhORYqDObIQi1uABFmBipAMpcoqsJL9zc0gVQhQQ"
        ]
        
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=fr-FR&page=\(page)&sort_by=popularity.desc" + (genre == 0 ? "" : "&with_genres=\(genre)")) else {
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
                            let title = result["title"] as? String,
                            let overview = result["overview"] as? String,
                            let releaseDate = result["release_date"] as? String,
                            let posterPath = result["poster_path"] as? String {
                            
                            let partialMovie = PartialMovie(id: id, title: title, overview: overview, release_date: releaseDate, poster_path: posterPath)
                            self.partialMovies.append(partialMovie)
                        }
                    }
                }
                
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
