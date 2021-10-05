//
//  WorkoutRow.swift
//  FitnessTracker
//
//  Created by Zaf on 30.9.21.
//

import SwiftUI

struct WorkoutRow: View {
    var workout: WorkoutEntity;
    var body: some View {
        VStack {
            HStack {
                Text(workout.name).font(.callout)
                    .foregroundColor(.black)
                    .padding(.bottom, 1);
                Spacer();
                Image(systemName: "chevron.right")
            }
            .padding();
        }
    }
}

struct WorkoutRow_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutRow(workout: EntityUtils.workout);
    }
}
