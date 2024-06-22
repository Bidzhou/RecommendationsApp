//
//  ContentCell.swift
//  RecommendationsApp
//
//  Created by Frederico del' Bidzho on 19.06.2024.
//

import SwiftUI

struct ContentCell: View {
    @State var filmInfo: FilmInfo?
    @State var uiImage = UIImage(systemName: "popcorn.fill")!

    var body: some View {
        VStack {
            Image(uiImage: self.uiImage)
                .resizable()
                .frame(width: screen.width*0.46, height: screen.height*0.28)
                .cornerRadius(6)
            Text(filmInfo?.name ?? "filmName")
                .font(.title)
                .lineLimit(1)
                .truncationMode(.head)
                .foregroundStyle(Color(.white))
            Text("\(String(filmInfo?.year ?? 1000))")
                .font(.headline)
                .foregroundStyle(Color(.white))
            Text("\((filmInfo?.rating.kp ?? 0.000).formatted())")
                .foregroundStyle(Color(.white))
        }
        .padding(3)
        .background(LinearGradient(colors: [Color("BloodRed"),Color(.black)], startPoint: .leading, endPoint: .trailing))
        .cornerRadius(3)
        .shadow(color: Color.red, radius: 20, x:5, y:5)
        .onAppear {
            Task {
                let result = try await APIWorkflow.shared.fetchData()
                
                self.filmInfo = result
                guard let img = try await UIImage(data: APIWorkflow.shared.loadImage(imageurl: result.poster.previewUrl)) else {return}
                uiImage = img
                
                
            }
        }
       
    }
        
}

#Preview {
    ContentCell()
}
