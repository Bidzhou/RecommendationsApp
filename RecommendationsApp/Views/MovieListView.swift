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
    @State var selectedItem: FilmInfo? = nil
    @State var showSheet = false
    let layout = [GridItem(.adaptive(minimum: screen.width/2.2))]
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground() // Настройка прозрачного фона
        appearance.backgroundColor = UIColor.black.withAlphaComponent(0.9)
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = UIColor.black // Установите нужный цвет
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            LazyVGrid(columns: layout, content: {
                ForEach(viewModel.avgFilm, id: \.id){ item in
                    Button(action: {
                        showSheet.toggle()
                        selectedItem = item
                    }, label: {
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
                                )
                    })
                    
                }
                
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
        .sheet(isPresented: $showSheet) {
            if let selectedItem = selectedItem {
                let detailViewModel = MovieDetalViewModel(Movie: selectedItem)
                MovieDetailView(viewModel: detailViewModel)
            }
        }
        .onAppear{
            viewModel.clearMoviesArray()
            Task{
               try await viewModel.fetchMoviesConcurrently(movCount: 8)
            }
        }

    }
}

#Preview {
    MovieListView()
}



