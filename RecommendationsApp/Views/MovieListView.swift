//
//  MovieListView.swift
//  RecommendationsApp
//
//  Created by Frederico del' Bidzho on 22.06.2024.
//

import SwiftUI

struct MovieListView: View {
    @StateObject var viewModel = MovieListViewModel()
    let layout = [GridItem(.adaptive(minimum: screen.width/2.2))]
    //@State var movieList: [FilmInfo]?
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            LazyVGrid(columns: layout, content: {
                ForEach(viewModel.avgFilm, id: \.id){ item in
                    
                    ContentCell(movieInf: item)
                }
                
            })
        }.navigationTitle(Text("helo"))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
        .onAppear{
            Task{
               try await viewModel.fetchMoviesConcurrently()
            }
            
            
            
            //guard viewModel.avgFilm.count > 3 else {return}
//            self.movieList = MovieListViewModel.shared.avgFilm
        }
        
    }
}

#Preview {
    MovieListView()
}

