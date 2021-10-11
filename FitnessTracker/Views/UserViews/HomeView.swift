//
//  HomeView.swift
//  FitnessTracker
//
//  Created by Zaf on 20.9.21.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homeViewModel = HomeViewModel();
    @State var workoutChanges: Bool = false;
    var body: some View {
        NavigationView() {
            VStack {
                VStack(alignment: .leading) {
                    Text("Welcome 👋")
                        .font(.title3)
                        .fontWeight(.bold);
                    Text("Looks like it's a good day to have a solid workout! Don't miss it")
                        .lineLimit(3);
                }
                .padding()
                .frame(height: 100);
                
                
                Divider()
                    .padding(.horizontal);
                
                HStack {
                    Text("Exercises")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray);
                    Spacer();
                }
                .padding(.horizontal)
                .padding(.top);
                HorizontalExercisesView(listOfExercises: homeViewModel.listOfExercises);
                
                Divider()
                    .padding(.horizontal);
                
                HStack {
                    Text("Workouts")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray);
                    Spacer();
                }
                .padding()
                
                
                VerticalWorkoutView(workouts: $homeViewModel.listOfWorkouts, workoutAdded: $workoutChanges)
                    .frame(height: 300);
            }
            .padding(.top, 50)
            .onAppear(perform: {
                homeViewModel.getWorkouts();
                
            })
            .navigationBarHidden(true);
        }
        .accentColor(.black);
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
