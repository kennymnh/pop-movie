//
//  FilmDetailsView.swift
//  Pop'Movie
//
//  Created by SDV Bordeaux on 18/01/2024.
//

import SwiftUI

struct FilmDetailsView: View {
    let film: Film
    var grildItems : [GridItem] = Array(repeating : .init(), count: 1)
    
    var body: some View {
        VStack {
            VStack(spacing: 10) {
                Text(film.title)
                    .font(.title.bold())
                    .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                Text(film.tagline)
                    .italic()
            }
            VStack {
                ZStack {
                    Image(film.poster_path)
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .frame(width:400 ,height: 350)
                }
            } //Vstack
            ZStack {
//                Rectangle()
//                    .foregroundColor(Color.gray)
//                    .opacity(0.5)
//                    .clipShape(RoundedRectangle(cornerRadius: 15))
//                    .frame(width:430, height: 350)
                VStack(spacing:30) {
                    HStack(spacing:80) {
                        Text(film.release_date)
                        Text("Durée \(Int(film.runtime)/60) h")
                    }
                    HStack(spacing:80) {
                        HStack{
                            Text("\(Int(film.popularity.rounded()))%")
                            Text("Note du public")
                        }
                        VStack {
                            Text("Catégories")
                            LazyHGrid(rows: grildItems, spacing: 20) {
                                ForEach(film.genres, id: \.name) {
                                    category in HStack {
                                        Text(category.name)
                                            .font(.subheadline)
                                    }
                                }
                            }
                        } //Vstack categories
                    }
                   
                    VStack{
                        Text("Description")
                            .font(.title2)
                        Text(film.overview)
                            .fontWidth(.condensed)
                    }
                    .frame(width:400)
                }
            } //Zstack
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
    }
        
        
}

#Preview {
    FilmDetailsView(film: .previewFilm)
}
