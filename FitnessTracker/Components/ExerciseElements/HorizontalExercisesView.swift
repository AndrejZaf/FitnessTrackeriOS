//
//  HorizontalExercisesView.swift
//  FitnessTracker
//
//  Created by Zaf on 26.9.21.
//

import SwiftUI

struct HorizontalExercisesView: View {
    var listOfExercises: [ExerciseEntity];
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                ForEach(0..<listOfExercises.count) { index in
                    NavigationLink(
                        destination: ExerciseView(exercise: listOfExercises[index]),
                        label: {
                            ExerciseElementView(exercise: listOfExercises[index])
                        }).isDetailLink(false);
                }.frame(height: 270)
            }.padding(.vertical)
        }.padding(.horizontal)
    }
}


struct HorizontalExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalExercisesView(listOfExercises: [EntityUtils.exercise, EntityUtils.exercise])
    }
}
