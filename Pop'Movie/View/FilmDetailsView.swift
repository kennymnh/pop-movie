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
            VStack(spacing: 30) {
                Text(film.title)
                    .font(.title.bold())
                    .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                Text(film.tagline)
                    .italic()
            }
            .foregroundColor(Color.white)
            
            HStack {
                Image(film.poster_path)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250)
                VStack {
                    HStack{
                        Text("\(film.popularity)%")
                        Text("Note du public")
                    }
                    .foregroundColor(Color.white)
                    Text("Catégories")
                        .font(Font.custom("PokemonSolidNormal", size: 20))
                        .foregroundColor(Color.white)
                    LazyHGrid(rows: grildItems, spacing: 40) {
                        ForEach(film.genres, id: \.name) {
                            category in HStack {
                                Text(category.name)
                                    .font(.subheadline)
                                    .foregroundColor(Color.white)
                            }
                        }
                    } //Vstack categories
                
                } //Vstack
            } //Hstack
            VStack{
                Text("Description")
                    .font(.title2)
                Text(film.overview)
                    .fontWidth(.condensed)
            }
            .foregroundColor(Color.white)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(Color.black)
    }
        
        
}

#Preview {
    FilmDetailsView(film: .previewFilm)
}
