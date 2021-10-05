//
//  ExerciseSecondaryRow.swift
//  FitnessTracker
//
//  Created by Zaf on 5.10.21.
//

import SwiftUI
    
    struct ExerciseSecondaryRow: View {
        var isSelected: Bool = false;
        var exercise: ExerciseEntity;
        var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    Text(exercise.name).font(.callout)
                        .foregroundColor(.black)
                        .padding(.bottom, 1);
                    HStack {
                        Text(exercise.level).font(.caption)
                            .foregroundColor(.secondary).fontWeight(.bold);
                        Text(exercise.primaryMuscle).font(.caption)
                            .foregroundColor(.secondary).fontWeight(.bold);
                    }
                }
                Spacer();
                
                
            }.padding()
        }
    }

    struct ExerciseSecondaryRow_Previews: PreviewProvider {
        static var previews: some View {
            ExerciseSecondaryRow(exercise: EntityUtils.exercise);
        }
    }
