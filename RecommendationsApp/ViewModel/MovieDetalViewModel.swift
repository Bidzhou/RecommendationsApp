//
//  MovieDetalViewModel.swift
//  RecommendationsApp
//
//  Created by Frederico del' Bidzho on 26.06.2024.
//

import Foundation

class MovieDetalViewModel: ObservableObject{
    @Published var Movie: FilmInfo
    init(Movie: FilmInfo) {
        self.Movie = Movie
    }
}
