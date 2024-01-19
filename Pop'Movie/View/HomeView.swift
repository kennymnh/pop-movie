//
//  HomeView.swift
//  Pop'Movie
//
//  Created by SDV Bordeaux on 18/01/2024.
//

import SwiftUI

struct HomeView: View {
    // MARK: PROPERTIES
    @StateObject var genreModel = GenreModel()
    @StateObject var partialMovieModel = PartialMovieModel()
    
    // MARK: BODY
    var body: some View {
        ScrollView {
            VStack {
                Text("Catégories")
                    // .foregroundStyle(.white)
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    // .shadow(color: .black, radius: 3)
                    .padding(.horizontal)
                    .padding(.top, 70)
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 20) {
                        ForEach(genreModel.genres) { genre in
                            
                            VStack() {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.gray.opacity(0.3))
                                    .frame(width: 200, height: 100)
                                    
                                    Text(genre.name)
                                        .font(.title2.bold())
                                        .foregroundStyle(.white)
                                        .shadow(color: .black, radius: 3)
                                        
                                }
                            }
                            
                        }
                    }
                    .padding(.leading, 8)
                }
                .padding()
            }
            .frame(width: UIScreen.main.bounds.width)
            
            
            VStack {
                Text("Tendances")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 40)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 30) {
                    
                    ForEach(partialMovieModel.partialMovies) { partialMovie in
                        
                        VStack(alignment: .leading) {
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500" + partialMovie.poster_path)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            } placeholder: {
                                ProgressView()
                            }
                            
                            Text(partialMovie.title)
                                .font(.title3.bold())
                                .lineLimit(1)
                                .padding(.leading, 3)
                        }
                        .padding(.horizontal, 8)
                        
                    }
                    
                }
                .padding()
                
                
                
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        //.background(Gradient(colors: [Color(.black.opacity(0.85)), Color(.black.opacity(0.9))]))
        .ignoresSafeArea(edges: .top)
        .task {
            await genreModel.fetchData()
            await partialMovieModel.fetchData()
        }
    }
}


// MARK: PREVIEW
#Preview {
    HomeView()
}
