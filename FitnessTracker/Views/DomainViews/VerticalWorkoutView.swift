//
//  VerticalWorkoutView.swift
//  FitnessTracker
//
//  Created by Zaf on 30.9.21.
//

import SwiftUI

struct VerticalWorkoutView: View {
    @Binding var workouts: [WorkoutEntity];
    var body: some View {
        ScrollView{
            ForEach(0..<workouts.indices.count, id: \.self) { index in
                NavigationLink(
                    destination: WorkoutDetailView(workout: workouts[index]),
                    label: {
                        WorkoutRow(workout: workouts[index]);
                    }).contextMenu(ContextMenu(menuItems: {
                        Button(action: {
                            let defaults = UserDefaults.standard.dictionary(forKey: "tokens")!["accessToken"];
                            WorkoutService().deleteWorkout(token: defaults as! String, workoutEntity: workouts[index]);
                            workouts.remove(at: index);
                        }, label: {
                            Text("Delete")
                        })
                    }))
            }
        }
    }
}

//struct VerticalWorkoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        VerticalWorkoutView(workouts: [EntityUtils.workout, EntityUtils.workout, EntityUtils.workout]);
//    }
//}
