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
    @Environment(\.presentationMode) var presentationMode;
    var body: some View {
        VStack {
            WorkoutExercisesView(exercises: $workout.exercises, editMode: $editMode)
                .navigationBarTitle(Text(workout.name), displayMode: .inline)
                .toolbar {
                    NavigationLink(destination: CreateEditWorkoutView(selectedExercises: workout.exercises, workoutName: workout.name,workoutUid: workout.uid, editMode: true), label: {
                        Image(systemName: "slider.horizontal.3");
                    });
                }
        }
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView(workout: EntityUtils.workout);
    }
}
