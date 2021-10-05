//
//  WorkoutExerciseRowView.swift
//  FitnessTracker
//
//  Created by Zaf on 30.9.21.
//

import SwiftUI

struct WorkoutExerciseRowView: View {
    var workoutExercise: WorkoutExerciseEntity;
    var body: some View {
        VStack {
            HStack {
                Text(workoutExercise.name).font(.callout)
                    .foregroundColor(.black)
                    .padding(.bottom, 1);
                Spacer();
            }
            .padding();
        }
    }
}

//struct WorkoutExerciseRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkoutExerciseRowView()
//    }
//}
