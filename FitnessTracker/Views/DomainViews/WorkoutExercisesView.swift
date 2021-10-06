//
//  WorkoutExercisesView.swift
//  FitnessTracker
//
//  Created by Zaf on 30.9.21.
//

import SwiftUI

struct WorkoutExercisesView: View {
    @Binding var exercises: [WorkoutExerciseEntity];
    @State private var showSheet = false;
    @Binding var editMode: Bool;
    var body: some View {
        List {
            ForEach(0..<exercises.indices.count, id: \.self) { index in
                NavigationLink(
                    destination:
                        BasicExerciseSetsView(exerciseSets: $exercises[index].exerciseSets, editMode: $editMode ,exerciseName: exercises[index].name),
                    label: {
                        WorkoutExerciseRowView(workoutExercise: exercises[index]);
                    })
            }
            .onDelete(perform: { indexSet in
                exercises.remove(at: indexSet.first!);
            }).deleteDisabled(!editMode)
        }
    }
}

//struct WorkoutExercisesView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkoutExercisesView()
//    }
//}
