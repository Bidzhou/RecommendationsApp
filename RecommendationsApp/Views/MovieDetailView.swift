//
//  FilmDetailView.swift
//  RecommendationsApp
//
//  Created by Frederico del' Bidzho on 26.06.2024.
//

import SwiftUI

struct MovieDetailView: View {
    var viewModel: MovieDetalViewModel
    @State var uiImage = UIImage(systemName: "popcorn.fill")!
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ScrollView {
            VStack(){
                Image(uiImage: uiImage)
                    .resizable()

                    .frame(width: screen.width*0.7, height: screen.height*0.34)
                    .cornerRadius(10)
                    .padding(8)
                    .background(LinearGradient(colors: [Color("BloodRed"),Color(.black)], startPoint: .bottom, endPoint: .top))
                    .cornerRadius(10)
                Text("\(viewModel.Movie.name ?? viewModel.Movie.alternativeName ?? "Noname")")
                    .font(.title.bold())
                    .fontWidth(.expanded)
                    .foregroundColor(.white)
                    .frame(width: screen.width*0.8,alignment: .center)
                
                Text("\(String(viewModel.Movie.year ?? 0))")
                    .font(.system(size: 24, weight: .regular, design: .default)
                            .italic()
                            .monospacedDigit())
                    
                    .fontWidth(.expanded)
                    .foregroundStyle(Color.white)
                    .padding(.bottom, 32)
                Text("Описание")
                    .foregroundStyle(Color.white)
                    .font(.title)
                    .fontWidth(.expanded)
                VStack(alignment: .leading){
                    Text(viewModel.Movie.description?.isEmpty == false ? viewModel.Movie.description! : "Описание отсутствует")
                        .foregroundStyle(Color.white)
                        .fontWidth(.expanded)
                        .frame(alignment: .leading)
                }.frame(maxWidth: screen.width*0.95)
                    .padding(.horizontal, 3)
                    .background(Color("myGray"))
                    .cornerRadius(5)
                    .padding(.bottom, 25)
                Button {
                    let url = URL(string: "https://www.kinopoisk.ru/film/" + String(viewModel.Movie.id))!
                    UIApplication.shared.open(url)
                } label: {
                    Text("Посмотерть подробно")
                        .foregroundStyle(Color.white)
                        .font(.headline.monospacedDigit())
                        .fontWeight(.thin)
                        .fontWidth(.expanded)
                    
                            
                }.padding(4)
                .background(Color("BloodRed"))
                .cornerRadius(10)

                
                Spacer()
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
        .onAppear {
            
            Task {

                guard let url = viewModel.Movie.poster.previewUrl ?? viewModel.Movie.poster.url else {
                    return
                }
                
                guard let img = try await UIImage(data: APIWorkflow.shared.loadImage(imageurl: url)) else {return}
                self.uiImage = img
                
            }
            
        }
        
        
    }
}

#Preview {
    MovieDetailView(viewModel: MovieDetalViewModel(Movie: FilmInfo(id: 1, name: "bobmaster bomboclat", alternativeName: "bobmaster2", year: 1987, description: "two bad guys", poster: FilmInfo.URLS(url: "https://image.openmoviedb.com/kinopoisk-images/1946459/bf93b465-1189-4155-9dd1-cb9fb5cb1bb5/orig", previewUrl: "https://image.openmoviedb.com/kinopoisk-images/1946459/bf93b465-1189-4155-9dd1-cb9fb5cb1bb5/orig"), rating: FilmInfo.Rates(kp: 0.0))))
}
