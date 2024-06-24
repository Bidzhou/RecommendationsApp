//
//  ContentView.swift
//  RecommendationsApp
//
//  Created by Frederico del' Bidzho on 17.06.2024.
//

import SwiftUI

struct GreetingView: View {
    @StateObject var viewModel = GreetingViewModel()
    @State var isButtonPushed = false
    private var timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center){
                Spacer()
                Image(systemName: viewModel.currentSymbol)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color("BloodRed"))
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.5), value: viewModel.currentSymbol)
                    .padding(.bottom, 40)
                Text("Откройте для себя что-то новое")
                    .foregroundStyle(Color.white)
                    .font(.title3.italic())
                Spacer()
                Button(action: {
                    isButtonPushed.toggle()
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
                    viewModel.changeSymbol()
                }
            })
        }.fullScreenCover(isPresented: $isButtonPushed, content: {
//            ContentCell(movieInf: FilmInfo(id: 1, name: "12", year: 123, description: "123", poster: FilmInfo.URLS(url: "https://image.openmoviedb.com/kinopoisk-images/1946459/bf93b465-1189-4155-9dd1-cb9fb5cb1bb5/orig", previewUrl: "https://image.openmoviedb.com/kinopoisk-images/1946459/bf93b465-1189-4155-9dd1-cb9fb5cb1bb5/orig"), rating: FilmInfo.Rates(kp: 5.5)))
            MovieListView()
        })
    }
}


#Preview {
    GreetingView()
}
