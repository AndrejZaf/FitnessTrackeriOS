//
//  WorkoutDetailView.swift
//  FitnessTracker
//
//  Created by Zaf on 30.9.21.
//

import SwiftUI

struct WorkoutDetailView: View {
    @State private var editMode: Bool = false;
    @State var workout: WorkoutEntity;
    @State private var workoutAdded: Bool = false;
    @Environment(\.presentationMode) var presentationMode;
    var body: some View {
        VStack {
            WorkoutExercisesView(exercises: $workout.exercises, editMode: $editMode)
            Spacer();
            
            NavigationLink(destination: FocusModeView(workout: workout), label: {
                Text("Focus Mode")
            })
            .navigationBarTitle(Text(workout.name), displayMode: .inline)
//            .toolbar {
//                NavigationLink(destination: CreateEditWorkoutView(selectedExercises: workout.exercises, workoutName: workout.name,workoutUid: workout.uid, showToastNotification: $workoutAdded, editMode: true), label: {
//                    Image(systemName: "slider.horizontal.3");
//                })
//            }
        }
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView(workout: EntityUtils.workout);
    }
}
