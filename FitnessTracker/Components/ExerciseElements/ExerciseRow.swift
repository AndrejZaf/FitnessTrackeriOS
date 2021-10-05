//
//  ExerciseRow.swift
//  FitnessTracker
//
//  Created by Zaf on 26.9.21.
//

import SwiftUI

struct ExerciseRow: View {
    var exercise: ExerciseEntity;
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(exercise.name).font(.callout)
                    .foregroundColor(.black)
                    .padding(.bottom, 1);
                Text(exercise.level).font(.caption)
                    .foregroundColor(.secondary).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/);
            }
            Spacer();
            Image(ImageUtils().getImageForMuscleGroup(muscleGroup: exercise.primaryMuscle)).resizable().frame(width: 40, height: 40);
        }.padding()
    }
}

struct ExerciseRow_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseRow(exercise: EntityUtils.exercise);
    }
}
