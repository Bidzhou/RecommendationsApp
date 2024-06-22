//
//  FilmInfo.swift
//  RecommendationsApp
//
//  Created by Frederico del' Bidzho on 19.06.2024.
//

import Foundation

struct FilmInfo: Decodable {
    let id : Int
    let name: String
    let year: Int
    let description: String
    let poster: URLS
    struct URLS: Codable {
        let url: String
        let previewUrl: String
    }
    let rating: Rates
    struct Rates: Codable {
        let kp: Double
    }
    
}
