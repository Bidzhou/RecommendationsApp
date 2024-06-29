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
    @Published var currentLike = "heart"
    let likeCondition = ["heart", "heart.fill"]
    func changeLikeButton(){
        if let curInd = likeCondition.firstIndex(of: currentLike) {
            currentLike = likeCondition[(curInd + 1) % likeCondition.count]
            print(currentLike)
        }
    }
}
