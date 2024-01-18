//
//  HomeView.swift
//  Pop'Movie
//
//  Created by SDV Bordeaux on 18/01/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            ZStack {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/1X7vow16X7CnCoexXh4H4F2yDJv.jpg")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 600)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("À découvrir")
                            .font(.largeTitle.bold())
                            .foregroundStyle(.white)
                            .shadow(color: .black, radius: 3)
                            .padding()
                            .padding(.top, 60)
                        Spacer()
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("suce")
                            .foregroundStyle(.white)
                            .font(.title.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .shadow(color: .black, radius: 3)
                            .padding(.horizontal)
                        
                        Text("There was a time, we used to lorem ipsum in order to lorem the ipsum of the conseqtus ipsum that doesn't mean anything, even me I don't know what the f I'm saying. This is just for this stupid placeholder text.")
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .shadow(color: .black, radius: 3)
                            .padding()
                    }
                }
                .frame(width: UIScreen.main.bounds.width)
            }
            
            VStack {
                LazyVStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.gray)
                        .frame(height: 200)
                }
                .padding()
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        .background(Gradient(colors: [Color(.black.opacity(0.85)), Color(.black.opacity(0.9))]))
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    HomeView()
}
