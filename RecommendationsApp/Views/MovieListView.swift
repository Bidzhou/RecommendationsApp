//
//  MovieListView.swift
//  RecommendationsApp
//
//  Created by Frederico del' Bidzho on 22.06.2024.
//

import SwiftUI

struct MovieListView: View {
    @StateObject var viewModel = MovieListViewModel()
    @State var changeFlag = false
    let layout = [GridItem(.adaptive(minimum: screen.width/2.2))]

    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            LazyVGrid(columns: layout, content: {
                ForEach(viewModel.avgFilm, id: \.id){ item in
                    
                    ContentCell(movieInf: item)
                        .background(
                            GeometryReader { proxy in
                                Color.clear
                                    .onAppear {
                                        let frame = proxy.frame(in: .global)
                                        if frame.maxY > UIScreen.main.bounds.height * 0.8 {
                                            Task{
                                                
                                                try await viewModel.addFewMovies(movCount: 2)

                                            }
                                        }
                                    }
                            }
                        )                }
                
            })
        }.navigationTitle(Text("helo"))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
        
        .onAppear{
            viewModel.clearMoviesArray()
            Task{
               try await viewModel.fetchMoviesConcurrently(movCount: 5)
            }
        }

    }
}

#Preview {
    MovieListView()
}

