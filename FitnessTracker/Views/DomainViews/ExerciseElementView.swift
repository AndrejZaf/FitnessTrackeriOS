//
//  ExerciseElementView.swift
//  FitnessTracker
//
//  Created by Zaf on 26.9.21.
//

import SwiftUI

struct ExerciseElementView: View {
    let exercise: ExerciseEntity;
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Image("image placeholder")
                    .resizable();
                VStack(alignment: .leading) {
                    Text(exercise.name)
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .lineLimit(1);
                    Text(exercise.description)
                        .foregroundColor(.black)
                        .font(.caption)
                        .lineLimit(3);
                    HStack {
                        // TODO: Swap these with the BadgeView
                        Text(CategoryUtils().determineCategory(category: exercise.category))
                            .foregroundColor(.black)
                            .padding(3)
                            .border(Color.gray)
                            .cornerRadius(1)
                            .font(.caption);
                        
                        Text(exercise.forceType)
                            .foregroundColor(.black)
                            .padding(3)
                            .border(Color.gray)
                            .cornerRadius(1)
                            .font(.caption);
                        
                        Text(exercise.primaryMuscle)
                            .foregroundColor(.black)
                            .padding(3)
                            .border(Color.gray)
                            .cornerRadius(1)
                            .font(.caption);
                    }
                }
            }
            .frame(width: 270, height: 270)
        }
    }
}

struct ExerciseElementView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseElementView(exercise: EntityUtils.exercise)
    }
}
