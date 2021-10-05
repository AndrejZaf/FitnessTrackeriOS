//
//  WorkoutDetailView.swift
//  FitnessTracker
//
//  Created by Zaf on 30.9.21.
//

import SwiftUI

struct WorkoutDetailView: View {
    @State private var editMode: Bool = false;
    var workout: WorkoutEntity;
    var body: some View {
        VStack {
            WorkoutExercisesView(exercises: workout.exercises)
                .navigationBarTitle(Text(workout.name), displayMode: .inline)
                .toolbar {
                    if editMode {
                        Button(action: {
                            editMode.toggle();
                        }, label: {
                            Image(systemName: "checkmark");
                        })
                    } else {
                        Button(action: {
                            editMode.toggle();
                        }, label: {
                            Image(systemName: "slider.horizontal.3");
                        })
                    }
                    
                }
            if editMode {
                HStack {
                    Spacer();
                    Button("\(Image(systemName: "plus.circle"))", action: {
                        
                    })
                        .font(.title)
                    Spacer();
                }
                .padding(.vertical)
            }
        }
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView(workout: EntityUtils.workout);
    }
}
