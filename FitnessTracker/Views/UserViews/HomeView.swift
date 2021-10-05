//
//  HomeView.swift
//  FitnessTracker
//
//  Created by Zaf on 20.9.21.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homeViewModel = HomeViewModel();
    
    var body: some View {
        NavigationView() {
            VStack {
                Text("Test").font(.headline)
                Text("Looks like it's a good day to have a solid workout! Don't miss it")
                Divider()
                    .padding(.horizontal);
                
                HStack {
                    Text("Exercises");
                    Spacer();
                }
                .padding(.horizontal)
                .padding(.top);
                HorizontalExercisesView(listOfExercises: homeViewModel.listOfExercises);
                
                Divider()
                    .padding(.horizontal);
                
                HStack {
                    Text("Workouts");
                    Spacer();
                }
                .padding(.horizontal)
                
                
                VerticalWorkoutView(workouts: homeViewModel.listOfWorkouts)
                    .frame(height: 300);
            }
//            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true);
        }
//        .navigationBarHidden(true);
//        .navigationViewStyle(StackNavigationViewStyle());
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
