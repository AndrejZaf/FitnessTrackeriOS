//
//  CreateEditWorkoutView.swift
//  FitnessTracker
//
//  Created by Zaf on 4.10.21.
//

import SwiftUI

struct CreateEditWorkoutView: View {
    @State var selectedExercises = [WorkoutExerciseEntity]();
    @State var workoutName: String = "";
    @State var listSelection: String = "";
    @State var workoutUid: String = "";
    @Environment(\.presentationMode) var presentationMode;
    var editMode: Bool = false;
    var body: some View {
        VStack {
            Form {
                TextField("Workout name", text: $workoutName);
                
                HStack {
                    NavigationLink(
                        destination: VerticalExercisesScrollView(exercises: $selectedExercises),
                        label: {
                            Text("Select exercises");
                        })
                }
                
                List{
                    ForEach(0..<selectedExercises.count, id: \.self) { index in
                        HStack {
                            Text(selectedExercises[index].name);
                            Spacer();
                            NavigationLink(
                                destination: SecondaryExerciseSetsView(exerciseSets: selectedExercises[index].exerciseSets, workoutExercise: $selectedExercises[index], exerciseName: selectedExercises[index].name, setType: SetType.Add),
                                label: {
                                    Image(systemName: "minus.circle");
                                })
                        }
                    }.onDelete(perform: { indexSet in
                        selectedExercises.remove(at: indexSet.first!);
                    })
                }
            }
            
            Spacer();
            
            if !editMode {
            Button(action: {
                let workoutEntity = WorkoutEntity(id: -1, uid: "", name: workoutName, exercises: selectedExercises);
                // Workout gets inserted in cloud DB, but not workoutExercise and setEntity
                let defaults = UserDefaults.standard.dictionary(forKey: "tokens")!["accessToken"];
                WorkoutService().addWorkout(token: defaults as! String, workoutEntity: workoutEntity);
                self.presentationMode.wrappedValue.dismiss();
            }, label: {
                Text("Add workout")
            })
            } else {
                Button(action: {
                    let workoutEntity = WorkoutEntity(id: -1, uid: workoutUid, name: workoutName, exercises: selectedExercises);
                    // Workout gets inserted in cloud DB, but not workoutExercise and setEntity
                    let defaults = UserDefaults.standard.dictionary(forKey: "tokens")!["accessToken"];
                    WorkoutService().updateWorkout(token: defaults as! String, workoutEntity: workoutEntity);
                    self.presentationMode.wrappedValue.dismiss();
                }, label: {
                    Text("Update Workout")
                })
            }
        }
        .navigationBarTitle(workoutName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CreateEditWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEditWorkoutView()
    }
}
