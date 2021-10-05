//
//  ExerciseSetRowView.swift
//  FitnessTracker
//
//  Created by Zaf on 1.10.21.
//

import SwiftUI

struct ExerciseSetRowView: View {
    var exerciseSet: SetEntity;
    @Binding var exerciseSets: [SetEntity];
    var indexSet: Int;
    var setType:SetType = SetType.View;
    var body: some View {
        if setType == SetType.Add {
            HStack {
                Text("Reps: \(exerciseSet.reps) -");
                Text("Weight: \(exerciseSet.weight)kg -");
                Text("Rest Period: \(exerciseSet.rest_period)s");
                Spacer();
                Button(action: {
                    exerciseSets.remove(at: indexSet);
                }, label: {
                    Image(systemName: "minus.circle");
                })
            }
            .padding();
        } else {
            HStack {
                Text("Reps: \(exerciseSet.reps) -");
                Text("Weight: \(exerciseSet.weight)kg -");
                Text("Rest Period: \(exerciseSet.rest_period)s");
            }
            .padding();
        }
        
    }
}
