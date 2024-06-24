//
//  APIWorkflow.swift
//  RecommendationsApp
//
//  Created by Frederico del' Bidzho on 19.06.2024.
//

import Foundation

class APIWorkflow {
    static let shared = APIWorkflow(); private init() { }
    private func createURL(_ num: Int) -> URL?{
        let tunnel = "https://" //туннель
        let server = "api.kinopoisk.dev" //адрес сервера
        let endpoint = "/v1.4/movie"
        let getParams = ["/535341", "/258687", "/435", "/326", "/361"]
        guard num <= getParams.count else {
            let urlStr = tunnel + server + endpoint + getParams[0]
            let url = URL(string: urlStr)
            return url
        }
        let urlStr = tunnel + server + endpoint + getParams[num]
        let url = URL(string: urlStr)
        return url
    }
    
    func fetchData(_ num: Int) async throws -> FilmInfo{
        guard let uRl = createURL(num) else {
            print("Фетч дата плохая ссылка")
            throw NetworkingError.badUrl
        }
        var request = URLRequest(url: (uRl))

        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = ["accept": "application/json","X-API-KEY": "bad api key"]
        let response = try await URLSession.shared.data(for: request)
        guard (response.1 as? HTTPURLResponse)?.statusCode == 200 else {
            print("Фетч дата плохой запрос")
            throw NetworkingError.badRequest
        }
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(FilmInfo.self, from: response.0)
            print(result)
            return result
        } catch {
            print("Фетч дата результат")
            throw NetworkingError.invalidData
        }

    }
    
    
   
    func loadImage(imageurl: String) async throws -> Data{
        guard let url = URL(string: imageurl) else {
            print("имаге")
            throw NetworkingError.badUrl
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = ["accept": "application/json","X-API-KEY": "bad api key"]
        let response = try await URLSession.shared.data(for: request)
        guard (response.1 as? HTTPURLResponse)?.statusCode == 200 else {
            print("имаге")
            throw NetworkingError.badRequest
        }
        print(response.0)
        return response.0


    }
    
//    func fetch1Data(completion: @escaping (Result<FilmInfo, Error>) -> Void) {
//        guard let url = createURL() else {
//            completion(.failure(NetworkingError.badUrl))
//            return
//        }
//        URLSession.shared.dataTask(with: url) { data, response, error in //специальный класс внутри свифта для работы с интернетом/сессией, у него етсь синглтон
//            guard let data else {
//                if let error {
//                    completion(.failure(error))
//                }
//                return
//            }
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            do {
//                let usersData = try decoder.decode(FilmInfo.self, from: data)
//                completion(.success(usersData))
//            } catch {
//                completion(.failure(NetworkingError.invalidData))
//            }
//            
//            
//            
//        }.resume()
        
//    }


}

enum NetworkingError: Error{
    case badUrl, badRequest, badResponse, invalidData
}
