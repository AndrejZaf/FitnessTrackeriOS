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
                HStack {
                    Text("Looks like it's a good day to have a solid workout! Don't miss it").lineLimit(3);
                }.padding(.horizontal)
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
                .padding()
                
                
                VerticalWorkoutView(workouts: $homeViewModel.listOfWorkouts, workoutAdded: $workoutChanges)
                    .frame(height: 300);
            }.onAppear(perform: {
                Repository.shared.getWorkouts(numberOfWorkouts: 10);
            })
//            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true);
        }.accentColor(.black);
//        .navigationBarHidden(true);
//        .navigationViewStyle(StackNavigationViewStyle());
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
