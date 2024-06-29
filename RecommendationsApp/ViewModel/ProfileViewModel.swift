//
//  ProfileViewModel.swift
//  RecommendationsApp
//
//  Created by Frederico del' Bidzho on 28.06.2024.
//

import Foundation
class ProfileViewModel: ObservableObject, Identifiable {
    static var shared = ProfileViewModel()
    @Published var likedMovies = [FilmInfo]()
//    init(likedMovies: [FilmInfo]){
//        self.likedMovies = likedMovies
//    }
    
    func addMovieToLikedList(_ movie: FilmInfo){
        self.likedMovies.append(movie)
        print("\(movie)")
    }
    func removeMovieFromLikedList(_ movie: FilmInfo){
        if let indexOfMovie = self.likedMovies.firstIndex(of: movie){
            self.likedMovies.remove(at: indexOfMovie)
            print("deleted")
        }
    }
    
}
