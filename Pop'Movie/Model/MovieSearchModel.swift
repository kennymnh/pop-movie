import Foundation

class MovieListViewModel: ObservableObject {
    @Published var resultPartialMovies: [PartialMovie] = []
    
    func fetchData(query: String, page: Int = 1) async {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5NjRhNDU0ODRjNGE4MDAyMmMyNWQyODBhNDc0MTQzOSIsInN1YiI6IjY1YTdlODc3NTFjMDFmMDEyYjYwYzI0NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.m0tbhORYqDObIQi1uABFmBipAMpcoqsJL9zc0gVQhQQ"
        ]
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/search/movie"
        components.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "include_adult", value: "true"),
            URLQueryItem(name: "language", value: "fr-FR"),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        guard let url = components.url else {
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
                           let posterPath = result["poster_path"] as? String,
                           let voteAverage = result["vote_average"] as? Double {
                            
                            let partialMovie = PartialMovie(id: id, title: title, overview: overview, release_date: releaseDate, poster_path: posterPath, vote_average: Float(voteAverage))
                            self.resultPartialMovies.append(partialMovie)
                        }
                    }
                }
                
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
