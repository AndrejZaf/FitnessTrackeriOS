//
//  ExerciseView.swift
//  FitnessTracker
//
//  Created by Zaf on 26.9.21.
//

import SwiftUI

struct ExerciseView: View {
    var exercise: ExerciseEntity;
    var body: some View {
        VStack(alignment: .leading) {
            Image("image placeholder")
                .resizable()
                .frame(height: 250);
            VStack(alignment: .leading) {
                Text(exercise.description).lineLimit(10);
                
                HStack {
                    exercise.primaryMuscle != "" ? BadgeView(text: exercise.primaryMuscle) : nil;
                
                    exercise.forceType != "" ? BadgeView(text: exercise.forceType) : nil;
                
                    exercise.level != "" ? BadgeView(text: exercise.level) : nil;
                
                    exercise.equipment != "" ? BadgeView(text: exercise.equipment) : nil;
                
                    exercise.mechanic != "" ? BadgeView(text: exercise.mechanic) : nil;
                }
                Spacer();
            }
            .padding(.horizontal);
            Spacer();
        }.navigationBarTitle(exercise.name, displayMode: .inline);
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(exercise: EntityUtils.exercise)
    }
}
