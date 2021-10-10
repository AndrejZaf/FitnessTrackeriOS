//
//  VerticalWorkoutView.swift
//  FitnessTracker
//
//  Created by Zaf on 30.9.21.
//

import SwiftUI

struct VerticalWorkoutView: View {
    @Binding var workouts: [WorkoutEntity];
    @State private var showLink = false;
    @State private var selection: Int? = nil;
    @Binding var workoutAdded: Bool;
    var body: some View {
        ScrollView{
            ForEach(0..<workouts.indices.count, id: \.self) { index in
                NavigationLink(
                    destination: WorkoutDetailView(workout: workouts[index]),
                    label: {
                        WorkoutRow(workout: workouts[index]);
                    })
                    .background(NavigationLink("", destination: CreateEditWorkoutView(selectedExercises: workouts[index].exercises, workoutName: workouts[index].name,workoutUid: workouts[index].uid, showToastNotification: $workoutAdded, editMode: true), tag: index, selection: $selection))
                    .contextMenu{
                        Button(action: {
                            selection = index;
                        }, label: {
                            Text("Edit")
                            Image(systemName: "slider.horizontal.3")
                        })
                        Button(action: {
                            let defaults = UserDefaults.standard.dictionary(forKey: "tokens")!["accessToken"];
                            WorkoutService().deleteWorkout(token: defaults as! String, workoutEntity: workouts[index]);
                            workouts.remove(at: index);
                        }, label: {
                            Text("Delete")
                            Image(systemName: "trash")
                        })
                    }
            }
        }
    }
}
