//
//  ContentView.swift
//  RecommendationsApp
//
//  Created by Frederico del' Bidzho on 17.06.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var currentSymbol = "movieclapper"
    private let symbols = ["movieclapper", "music.mic.circle.fill", "headphones", "popcorn.fill"]
    private var timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center){
                Spacer()
                Image(systemName: currentSymbol)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color("BloodRed"))
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.5), value: currentSymbol)
                Spacer()
                Button(action: {
                    
                }, label: {
                    Text("Приступить к просмотру")
                        .foregroundColor(.white)
                        .font(.custom("callout", size: 18))
                        .padding(8)
                        .padding(.horizontal, 24)
                        .background(Color("BloodRed"))
                        .cornerRadius(16)
                })
            }        .onReceive(timer, perform: { _ in
                withAnimation {
                    changeSymbol()
                }
            })
        }

        

        
    }
    private func changeSymbol() {
        if let currentIndex = symbols.firstIndex(of: currentSymbol){
            let nextIndex = (currentIndex + 1) % symbols.count
            currentSymbol = symbols[nextIndex]
        }
    }
        
}


#Preview {
    ContentView()
}
