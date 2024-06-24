//
//  ContentCell.swift
//  RecommendationsApp
//
//  Created by Frederico del' Bidzho on 19.06.2024.
//

import SwiftUI

struct ContentCell: View {
    //@State var filmInfo: FilmInfo?
    @State var movieInf: FilmInfo
    @State var uiImage = UIImage(systemName: "popcorn.fill")!
    
    var body: some View {
        VStack {
            Image(uiImage: self.uiImage)
                .resizable()
                .frame(width: screen.width*0.46, height: screen.height*0.28)
                .cornerRadius(6)
            Text("\(movieInf.name ?? movieInf.alternativeName ?? "дулбуёп")")
                .font(.title)
                .frame(maxWidth: screen.width*0.46)
                .lineLimit(1)
                .truncationMode(.tail)
                .foregroundStyle(Color(.white))
            Text("\(String(movieInf.year))")
                .font(.headline)
                .foregroundStyle(Color(.white))
            Text("\(movieInf.rating.kp != nil ? String(format: "%.1f", movieInf.rating.kp!) : "no rating(")")
                .foregroundStyle(Color(.white))
        }
        .padding(3)
        .background(LinearGradient(colors: [Color("BloodRed"),Color(.black)], startPoint: .leading, endPoint: .trailing))
        .cornerRadius(3)
        //.shadow(color: Color.red, radius: 20, x:5, y:5)
        .onAppear {
            
            Task {
                //let result = try await APIWorkflow.shared.fetchData()
                
                //self.filmInfo = result
                //self.movieInf = result
                guard let url = movieInf.poster.previewUrl ?? movieInf.poster.url else {
                    return
                }
                
                guard let img = try await UIImage(data: APIWorkflow.shared.loadImage(imageurl: url)) else {return}
                self.uiImage = img
                
                
            }
                


                
                
            
        }
       
    }
        
}

#Preview {
    ContentCell(movieInf: FilmInfo(id: 1,
                                   name: "agiga",
                                   alternativeName: "bobbi&others",
                                   year: 1987,
                                   description: "2 sticks",
                                   poster: FilmInfo.URLS(url: "https://image.openmoviedb.com/kinopoisk-images/1946459/bf93b465-1189-4155-9dd1-cb9fb5cb1bb5/orig", previewUrl: "https://image.openmoviedb.com/kin opoisk-images/1946459/bf93b465-1189-4155-9dd1-cb9fb5cb1bb5/orig"),
                                   rating: FilmInfo.Rates(kp: 8.8)))
}

