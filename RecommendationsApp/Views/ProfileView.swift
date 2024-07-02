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
    @State var isChangeProfilePic = false
    @State var image = UIImage(named: "baby")!
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                Image(uiImage: self.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .background(Color.black)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color("BloodRed"), lineWidth: 2)
                    )
                    .padding(4)
                    
                    .onTapGesture {
                        isChangeProfilePic.toggle()
                    }
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

                
                ProfileViewCell(movie: film)
                    .onTapGesture {
                        
                        profileSelectedItem = film
                        profileSelectedItem = profileSelectedItem!
                        isProfileShowSheet.toggle()

                    }
                

            }
            
            
            

            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
            .sheet(isPresented: $isProfileShowSheet, content: {
                if let selectedItem = profileSelectedItem {
                    let detailViewModel = MovieDetalViewModel(Movie: selectedItem)
                    MovieDetailView(viewModel: detailViewModel)
                } else {
                    Text("wer")
                }
            })

            .sheet(isPresented: $isChangeProfilePic) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
            }

    }
    
}

#Preview {
    ProfileView()
}
