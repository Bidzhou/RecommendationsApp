//
//  GreetingViewModel.swift
//  RecommendationsApp
//
//  Created by Frederico del' Bidzho on 19.06.2024.
//

import Foundation

class GreetingViewModel: ObservableObject {
    @Published var currentSymbol = "movieclapper"
    let symbols = ["movieclapper", "music.mic.circle.fill", "headphones", "popcorn.fill"]
    
    func changeSymbol(){
        if let currentIndex = symbols.firstIndex(of: currentSymbol){
            let nextIndex = (currentIndex + 1) % symbols.count
            currentSymbol = symbols[nextIndex]
        }
    }
}

