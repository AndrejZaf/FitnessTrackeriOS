//
//  VerticalWorkoutView.swift
//  FitnessTracker
//
//  Created by Zaf on 30.9.21.
//

import SwiftUI

struct VerticalWorkoutView: View {
    var workouts: [WorkoutEntity];
    var body: some View {
        ScrollView{
            ForEach(0..<workouts.count) { index in
                NavigationLink(
                    destination: WorkoutDetailView(workout: workouts[index]),
                    label: {
                        WorkoutRow(workout: workouts[index]);
                    })
            }
        }
    }
}

struct VerticalWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        VerticalWorkoutView(workouts: [EntityUtils.workout, EntityUtils.workout, EntityUtils.workout]);
    }
}
