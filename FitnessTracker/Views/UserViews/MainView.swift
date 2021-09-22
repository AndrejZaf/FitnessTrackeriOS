//
//  MainView.swift
//  FitnessTracker
//
//  Created by Zaf on 21.9.21.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem { Image(systemName: "house") }
            ExercisesView()
                .tabItem { Image(systemName: "square") }
            WorkoutView()
                .tabItem { Image(systemName: "square") }
            ProfileView()
                .tabItem { Image(systemName: "square") }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
