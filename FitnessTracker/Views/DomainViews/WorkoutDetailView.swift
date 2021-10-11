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
            WorkoutExercisesView(exercises: $workout.exercises, editMode: $editMode).navigationBarTitle(Text(workout.name), displayMode: .inline)
            Spacer();
            
            if workout.exercises.count > 0 {
                NavigationLink(destination: FocusModeView(workout: workout), label: {
                    Text("Focus Mode")
                })
                .buttonStyle(CustomButtonStyle(backgroundColor: .black, foregroundColor: .white, isDisabled: false))
            }
        }
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView(workout: EntityUtils.workout);
    }
}
