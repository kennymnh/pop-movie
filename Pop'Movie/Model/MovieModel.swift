import Foundation

class MovieModel: ObservableObject {
    @Published var movie: Movie = Movie.previewMovie
    @Published var actors: [CastPerson] = Array(repeating: CastPerson.previewActor, count: 4)
    
    func fetchData(movieId: Int = 0) async {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5NjRhNDU0ODRjNGE4MDAyMmMyNWQyODBhNDc0MTQzOSIsInN1YiI6IjY1YTdlODc3NTFjMDFmMDEyYjYwYzI0NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.m0tbhORYqDObIQi1uABFmBipAMpcoqsJL9zc0gVQhQQ"
        ]
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?language=fr-FR") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    
                    if let id = json["id"] as? Int,
                       let title = json["title"] as? String,
                       let overview = json["overview"] as? String,
                       let releaseDate = json["release_date"] as? String,
                       let status = json["status"] as? String,
                       let popularity = json["popularity"] as? Double,
                       let voteAverage = json["vote_average"] as? Double,
                       let voteCount = json["vote_count"] as? Int,
                       let adult = json["adult"] as? Bool,
                       let backdropPath = json["backdrop_path"] as? String,
                       let posterPath = json["poster_path"] as? String,
                       let budget = json["budget"] as? Int,
                       let genresData = json["genres"] as? [[String: Any]]
                    {
                        
                        var genres: [Genre] = []
                        
//                        for genreData in genresData{
//                            if let genreId = genreData["id"] as? Int,
//                               let genreName = genreData["name"] as? String {
//                                genres.append(Genre(id: genreId, name: genreName))
//                            }
//                        }
                        // TODO: countries
                        // TODO: prod companies
                        // TODO: spoken languages
                        
                        // let partialMovie = PartialMovie(id: id, title: title, overview: overview, release_date: releaseDate, poster_path: posterPath)
                        // self.partialMovies.append(partialMovie)
                        
                        movie = Movie(id: id, title: title, overview: overview, releaseDate: releaseDate, status: "", popularity: Float(popularity), voteAverage: Float(voteAverage), voteCount: voteCount, adult: adult, genres: genres, backdropPath: backdropPath, posterPath: posterPath, countries: [], productionCompanies: [], spokenLanguages: [], budget: budget)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
