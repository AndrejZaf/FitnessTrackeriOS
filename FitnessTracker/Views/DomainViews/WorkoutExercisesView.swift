//
//  WorkoutExercisesView.swift
//  FitnessTracker
//
//  Created by Zaf on 30.9.21.
//

import SwiftUI

struct WorkoutExercisesView: View {
    var exercises: [WorkoutExerciseEntity];
    @State private var showSheet = false;
    var body: some View {
        List {
            ForEach(0..<exercises.count) { index in
                NavigationLink(
                    destination:
                        BasicExerciseSetsView(exerciseSets: exercises[index].exerciseSets, exerciseName: exercises[index].name),
                    label: {
                            WorkoutExerciseRowView(workoutExercise: exercises[index]);
                    })
            }.onDelete(perform: { indexSet in
                print(indexSet);
            })
        }
    }
}

//struct WorkoutExercisesView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkoutExercisesView()
//    }
//}
