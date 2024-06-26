//
//  MainTabBar.swift
//  RecommendationsApp
//
//  Created by Frederico del' Bidzho on 22.06.2024.
//

import SwiftUI

struct MainTabBar: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            TabView{
                NavigationStack {
                    MovieListView()
                }
                .tabItem {
                    VStack {
                        Image(systemName: "list.bullet.circle.fill")
                        Text("Movies")
                    }
                }
            }.accentColor(Color("BloodRed"))
        }
    }
}

#Preview {
    MainTabBar()
}
