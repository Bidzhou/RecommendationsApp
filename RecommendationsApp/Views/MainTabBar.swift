//
//  MainTabBar.swift
//  RecommendationsApp
//
//  Created by Frederico del' Bidzho on 22.06.2024.
//

import SwiftUI

struct MainTabBar: View {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground() // Настройка прозрачного фона
        appearance.backgroundColor = UIColor.black.withAlphaComponent(0.9)
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = UIColor.black // Установите нужный цвет
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
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
                NavigationStack {
                    ProfileView()
                }
                .tabItem {
                    VStack {
                        Image(systemName: "person.circle.fill")
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
