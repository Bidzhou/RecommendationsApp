//
//  APIWorkflow.swift
//  RecommendationsApp
//
//  Created by Frederico del' Bidzho on 19.06.2024.
//

import Foundation

class APIWorkflow {
    static let shared = APIWorkflow(); private init() { }
    private func createURL() -> URL?{
        let tunnel = "https://" //туннель
        let server = "api.kinopoisk.dev" //адрес сервера
        let endpoint = "/v1.4/movie/"
        let getParams = "535341"//еще есть параметры(ссылка где есть в конце вопросы знаки равно и тд.(параметры))
        let urlStr = tunnel + server + endpoint + getParams
        let url = URL(string: urlStr)
        return url
    }
    
    func fetchData() async throws -> FilmInfo{
        var request = URLRequest(url: (createURL() ?? URL(string: "https://api.kinopoisk.dev/v1.4/movie/random")!))
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = ["accept": "application/json","X-API-KEY": "bad api key"]
        let response = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        
        let result = try decoder.decode(FilmInfo.self, from: response.0)
        return result
    }
    
    
   
    func loadImage(imageurl: String) async throws -> Data{
        var request = URLRequest(url: URL(string: imageurl)!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = ["accept": "application/json","X-API-KEY": "bad api key"]
        let response = try await URLSession.shared.data(for: request)
        return response.0
    }
    

    

}


