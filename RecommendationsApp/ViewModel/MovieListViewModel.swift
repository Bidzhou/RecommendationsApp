//
//  MovieListViewModel.swift
//  RecommendationsApp
//
//  Created by Frederico del' Bidzho on 22.06.2024.
//

import Foundation

class MovieListViewModel: ObservableObject {
    static let shared = MovieListViewModel()
    @Published var isOnLoad = false
    @Published var avgFilm = [FilmInfo(id: 1,
                            name: "badnbouje", alternativeName: "agiga",
                            year: 1987,
                            description: "two bad gyus etc.",
                            poster: FilmInfo.URLS(url: ";ald", previewUrl: "sldnf"),
                            rating: FilmInfo.Rates(kp: 5.5)), FilmInfo(id: 2,
                                                                       name: "badnbouje", alternativeName: "bob marlety",
                                                                       year: 1987,
                                                                       description: "two bad gyus etc.",
                                                                       poster: FilmInfo.URLS(url: ";ald", previewUrl: "sldnf"),
                                                                       rating: FilmInfo.Rates(kp: 5.5))]

    func fetchMoviesConcurrently(movCount: Int) async throws -> [FilmInfo] {
        try await withThrowingTaskGroup(of: FilmInfo.self) { group in
            for _ in 1...movCount {
                group.addTask {
                    return try await APIWorkflow.shared.fetchData(5)
                }
            }

            let results: [FilmInfo] = []
            
            for try await result in group {
                    DispatchQueue.main.async{
                        self.avgFilm.append(result)
                    }
            }

            return results
            
        }
    }
    func clearMoviesArray(){
        self.avgFilm.removeAll()
    }
    
    func addFewMovies(movCount: Int) async throws -> (){
        guard !isOnLoad else {return}
        DispatchQueue.main.async{
            self.isOnLoad = true
        }
        Task {
            try await fetchMoviesConcurrently(movCount: movCount)
        }
        DispatchQueue.main.async{
            self.isOnLoad = false
        }
    }

}
