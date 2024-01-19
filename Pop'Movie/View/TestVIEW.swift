//
//  TestVIEW.swift
//  Pop'Movie
//
//  Created by SDV Bordeaux on 19/01/2024.
//

import SwiftUI

struct TestVIEW: View {
    // MARK: PROPERTIES
    @StateObject var genreModel = GenresModel()
    @StateObject var partialMovieModel = PartialMoviesModel()
    
    // Track if we are currently loading more movies to prevent multiple requests.
    @State private var isLoadingMore = false
    @State private var currentPage = 1
    
    // MARK: BODY
    var body: some View {
        ScrollView {
            
            ScrollViewReader { scrollViewProxy in
                VStack {
                    Text("Tendances")
                        .font(.largeTitle.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top, 80)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 30) {
                        
                        ForEach(partialMovieModel.partialMovies) { partialMovie in
                            
                            VStack(alignment: .leading) {
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500" + partialMovie.poster_path)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(2/3, contentMode: .fit)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                } placeholder: {
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(.gray)
                                            .opacity(0.1)
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                            .aspectRatio(2/3, contentMode: .fill)
                                        
                                        ProgressView()
                                    }
                                }
                                
                                Text(partialMovie.title)
                                    .font(.title3.bold())
                                    .lineLimit(1)
                                    .padding(.leading, 3)
                            }
                            .padding(.horizontal, 8)
                            
                            .onAppear {
                                // When the last movie appears, load more movies
                                if !isLoadingMore && partialMovie.id == partialMovieModel.partialMovies.last?.id {
                                    isLoadingMore = true
                                    
                                    Task {
                                        await partialMovieModel.fetchData(page: currentPage + 1)
                                        currentPage += 1
                                        isLoadingMore = false
                                    }
                                    
                                }
                            }
                            
                        }
                        
                    }
                    .padding()
                    
                    
                    
                }
//                .frame(width: UIScreen.main.bounds.width)

            }
        }
        .ignoresSafeArea(edges: .top)
        .task {
            await genreModel.fetchData()
            await partialMovieModel.fetchData()
        }
    }
}

#Preview {
    TestVIEW()
}
