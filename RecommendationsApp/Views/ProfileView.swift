//
//  ProfileView.swift
//  RecommendationsApp
//
//  Created by Frederico del' Bidzho on 28.06.2024.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel.shared
    @State var profileSelectedItem: FilmInfo? = nil
    @State var isProfileShowSheet = false
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                Image(systemName: "person")
                    .resizable()
                    .foregroundStyle(Color("BloodRed"))
                    .frame(width: 100, height: 100)
                    .padding(18)
                    .background(Color.black)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color("BloodRed"), lineWidth: 2)
                    )
                    .padding(4)
                Text("Frederico")
                    .foregroundStyle(.white)
                    .font(.system(size: 24))
                        .italic()
                        .monospacedDigit()
                    .fontWidth(.expanded)
                    .padding(.bottom, 25)
                Text("Liked items:")
                    .foregroundStyle(.white)
                    .font(.system(size: 24))
                        .italic()
                        .monospacedDigit()
                    .fontWidth(.expanded)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 10)

            }
            
            ForEach(viewModel.likedMovies, id: \.id) { film in
                Button{
                    profileSelectedItem = film
                    isProfileShowSheet.toggle()
                } label: {
                    ProfileViewCell(movie: film)
                }
                

            }
            
            
            

            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
            .sheet(isPresented: $isProfileShowSheet, content: {
                if let selectedItem = profileSelectedItem {
                    let detailViewModel = MovieDetalViewModel(Movie: selectedItem)
                    MovieDetailView(viewModel: detailViewModel)
                }
            })
            .onAppear{
                print(viewModel.likedMovies)
            }

    }
    
}

#Preview {
    ProfileView()
}
