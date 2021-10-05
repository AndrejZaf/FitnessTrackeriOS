//
//  WorkoutView.swift
//  FitnessTracker
//
//  Created by Zaf on 21.9.21.
//

import SwiftUI

struct WorkoutView: View {
    @StateObject private var workoutViewModel = WorkoutViewModel();
    @State private var searchState: String = "";
    var body: some View {
        NavigationView {
            VStack{
                TextField("Search for a workout", text: $searchState)
                .textFieldStyle(CustomTextFieldStyle())
                    .padding(.horizontal);
                
                VerticalWorkoutView(workouts: workoutViewModel.listOfWorkouts);
                Divider();
                HStack {
                    Spacer();
                    NavigationLink(
                        destination: CreateEditWorkoutView(),
                        label: {
                            Text("\(Image(systemName: "plus.circle"))")
                                .font(.title)
                        });
                    Spacer();
                }
                .padding(.vertical)
                Spacer();
            }
            .padding(.top)
            .navigationBarHidden(true);
        }.navigationViewStyle(StackNavigationViewStyle());
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
