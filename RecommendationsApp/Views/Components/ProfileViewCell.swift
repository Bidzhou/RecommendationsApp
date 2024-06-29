//
//  ProfileViewCell.swift
//  RecommendationsApp
//
//  Created by Frederico del' Bidzho on 28.06.2024.
//

import SwiftUI

struct ProfileViewCell: View {
    @State var movie: FilmInfo
    @State var uiImage = UIImage(systemName:"popcorn")!
    var body: some View {
        VStack{
            HStack{
                
                Image(uiImage: self.uiImage)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .cornerRadius(10)
                Text("\(movie.name ?? movie.alternativeName ?? "дулбуёп")")
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .foregroundStyle(.white)
                    .font(.system(size: 29))
            }.frame(maxWidth: .infinity,alignment:.leading)
                .padding(.top,3)
            HStack(spacing: screen.width * 0.4) {
                Text("\(String(movie.year ?? 0))")
                    .foregroundStyle(.white)
                
                Text("\(.init(systemName: "trophy")) \((movie.rating.kp ?? 0.0).formatted())")
                    .foregroundStyle(.white)
                
            }
        } .frame(maxWidth: screen.width*0.96)
            .padding(4)
            
            .background(Color("BloodRed"))
            .cornerRadius(18)
        .onAppear {
            
            Task {

                guard let url = movie.poster.previewUrl ?? movie.poster.url else {
                    return
                }
                
                guard let img = try await UIImage(data: APIWorkflow.shared.loadImage(imageurl: url)) else {return}
                self.uiImage = img
                
            }
            
        }
        
    }
        
}

#Preview {
    ProfileViewCell(movie: FilmInfo(id: 1,
                                    name: "Agiga",
                                    alternativeName: "bobbi&others",
                                    year: 1987,
                                    description: "2 sticks",
                                    poster: FilmInfo.URLS(url: "https://image.openmoviedb.com/kinopoisk-images/1946459/bf93b465-1189-4155-9dd1-cb9fb5cb1bb5/orig", previewUrl: "https://image.openmoviedb.com/kin opoisk-images/1946459/bf93b465-1189-4155-9dd1-cb9fb5cb1bb5/orig"),
                                    rating: FilmInfo.Rates(kp: 8.8)))
}
