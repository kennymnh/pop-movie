//
//  FilmData.swift
//  Pop'Movie
//
//  Created by SDV Bordeaux on 18/01/2024.
//

import Foundation

struct Film: Codable, Identifiable {
    let id: Int
    let original_language: String
    let original_title: String
    let tagline: String
    let overview: String
    let popularity: Float
    let poster_path: String
    let release_date: String
    let title: String
    let vote_average: Float
    let vote_count: Int
    let budget: Int
    let revenue: Int
    let genres: [FilmGenre]
    
    struct FilmGenre : Codable {
        let id: Int
        let name: String
    }
}

extension Film {
    static let previewFilm: Film = Film(id:13, original_language: "en", original_title: "Forrest Gump", tagline: "Le monde ne sera plus jamais le même quand vous l’aurez vu avec les yeux de Forrest Gump.", overview: "Durant trois décennies particulièrement agitées, Forrest Gump vit une série d'aventures le propulsant de l'état de handicapé physique à celui de star du football, de héros du Vietnam au roi de la crevette, des honneurs de la Maison Blanche au bonheur d'une grande histoire d'amour. Forrest est le symbole d'une époque, un candide dans une Amérique qui a perdu son innocence. Son cœur dépasse les limites de son QI…", popularity: 84.609, poster_path: "forrest", release_date: "1994-06-23", title: "Forest Gump", vote_average: 8.477, vote_count: 26018, budget:55000000, revenue: 677387716,genres: [(FilmGenre(id: 35, name: "Comedie"))])
}

//{
//  "adult": false,
//  "backdrop_path": "/qdIMHd4sEfJSckfVJfKQvisL02a.jpg",
//  "belongs_to_collection": null,
//  "budget": 55000000,
//  "genres": [
//    {
//      "id": 35,
//      "name": "Comédie"
//    },
//    {
//      "id": 18,
//      "name": "Drame"
//    },
//    {
//      "id": 10749,
//      "name": "Romance"
//    }
//  ],
//  "homepage": "",
//  "id": 13,
//  "imdb_id": "tt0109830",
//  "original_language": "en",
//  "original_title": "Forrest Gump",
//  "overview": "Durant trois décennies particulièrement agitées, Forrest Gump vit une série d'aventures le propulsant de l'état de handicapé physique à celui de star du football, de héros du Vietnam au roi de la crevette, des honneurs de la Maison Blanche au bonheur d'une grande histoire d'amour. Forrest est le symbole d'une époque, un candide dans une Amérique qui a perdu son innocence. Son cœur dépasse les limites de son QI…",
//  "popularity": 84.609,
//  "poster_path": "/A0Th0x8QIzP0njrFAJnYQ5ouIoB.jpg",
//  "production_companies": [
//    {
//      "id": 4,
//      "logo_path": "/gz66EfNoYPqHTYI4q9UEN4CbHRc.png",
//      "name": "Paramount",
//      "origin_country": "US"
//    },
//    {
//      "id": 21920,
//      "logo_path": null,
//      "name": "The Steve Tisch Company",
//      "origin_country": ""
//    },
//    {
//      "id": 412,
//      "logo_path": null,
//      "name": "Wendy Finerman Productions",
//      "origin_country": ""
//    }
//  ],
//  "production_countries": [
//    {
//      "iso_3166_1": "US",
//      "name": "United States of America"
//    }
//  ],
//  "release_date": "1994-06-23",
//  "revenue": 677387716,
//  "runtime": 120,
//  "spoken_languages": [
//    {
//      "english_name": "English",
//      "iso_639_1": "en",
//      "name": "English"
//    }
//  ],
//  "status": "Released",
//  "tagline": "Le monde ne sera plus jamais le même quand vous l’aurez vu avec les yeux de Forrest Gump.",
//  "title": "Forrest Gump",
//  "video": false,
//  "vote_average": 8.477,
//  "vote_count": 26018
//}
