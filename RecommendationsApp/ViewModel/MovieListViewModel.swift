//
//  MovieListViewModel.swift
//  RecommendationsApp
//
//  Created by Frederico del' Bidzho on 22.06.2024.
//

import Foundation

class MovieListViewModel: ObservableObject {
    static let shared = MovieListViewModel()
    @Published var avgFilm = [FilmInfo(id: 1,
                            name: "badnbouje",
                            year: 1987,
                            description: "two bad gyus etc.",
                            poster: FilmInfo.URLS(url: ";ald", previewUrl: "sldnf"),
                            rating: FilmInfo.Rates(kp: 5.5)), FilmInfo(id: 2,
                                                                       name: "badnbouje",
                                                                       year: 1987,
                                                                       description: "two bad gyus etc.",
                                                                       poster: FilmInfo.URLS(url: ";ald", previewUrl: "sldnf"),
                                                                       rating: FilmInfo.Rates(kp: 5.5))]
//    func getMovies(){
//        avgFilm.removeAll()
//        
//        Task{
//            
//            let res = try await APIWorkflow.shared.fetchData()
//            avgFilm.append(res)
//        }
//        
//    }
    func fetchMoviesConcurrently() async throws -> [FilmInfo] {
        try await withThrowingTaskGroup(of: FilmInfo.self) { group in
            for i in 1...3 {
                group.addTask {
                    return try await APIWorkflow.shared.fetchData(i)
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
//    func addMovies() async throws -> [FilmInfo]{
//        do{
//            self.avgFilm += try await fetchMoviesConcurrently()
//            return self.avgFilm
//        } catch {
//            print("не удалось добавить еще фильмов")
//            throw NetworkingError.invalidData
//        }
//        
//    }
}
