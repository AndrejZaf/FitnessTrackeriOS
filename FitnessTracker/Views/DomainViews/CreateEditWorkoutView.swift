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
    @State private var showToast: Bool = false;
    @Binding var showToastNotification: Bool;
    @Environment(\.presentationMode) var presentationMode;
    private let queue = DispatchQueue(label: "createUpdateQueue", attributes: .concurrent);
    var editMode: Bool = false;
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Workout Specifics")) {
                    TextField("Workout name", text: $workoutName);
                    
                    HStack {
                        NavigationLink(
                            destination: VerticalExercisesScrollView(exercises: $selectedExercises),
                            label: {
                                Text("Select exercises");
                            })
                    }
                }
                
                Section(header:Text("Exercises")){
                    List{
                        ForEach(0..<selectedExercises.count, id: \.self) { index in
                            HStack {
                                Text(selectedExercises[index].name);
                                Spacer();
                                NavigationLink(
                                    destination: SecondaryExerciseSetsView(exerciseSets: selectedExercises[index].exerciseSets, workoutExercise: $selectedExercises[index], exerciseName: selectedExercises[index].name, setType: SetType.Add),
                                    label: {
                                    })
                            }
                        }.onDelete(perform: { indexSet in
                            selectedExercises.remove(at: indexSet.first!);
                        })
                    }
                }
            }
            
            Spacer();
            
            if !editMode {
                CustomButton(title: "Add Workout", disabled: false, backgroundColor: .black, foregroundColor: .white, action: {
                    let workoutEntity = WorkoutEntity(id: -1, uid: "", name: workoutName, exercises: selectedExercises);
                    let defaults = UserDefaults.standard.dictionary(forKey: "tokens")!["accessToken"];
                    
                    showToast = true;
                    self.queue.async {
                        RegulatorService.shared.acquire();
                        JwtService().checkTokenValidity();
                        RegulatorService.shared.acquire();
                        WorkoutService().addWorkout(token: defaults as! String, workoutEntity: workoutEntity);
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        showToast = false;
                        showToastNotification = true;
                        self.presentationMode.wrappedValue.dismiss();
                    })
                })
            } else {
                CustomButton(title: "Update Workout", disabled: false, backgroundColor: .black, foregroundColor: .white, action: {
                    let workoutEntity = WorkoutEntity(id: -1, uid: workoutUid, name: workoutName, exercises: selectedExercises);
                    let defaults = UserDefaults.standard.dictionary(forKey: "tokens")!["accessToken"];
                    
                    showToast = true;
                    self.queue.async {
                        RegulatorService.shared.acquire();
                        JwtService().checkTokenValidity();
                        RegulatorService.shared.acquire();
                        WorkoutService().updateWorkout(token: defaults as! String, workoutEntity: workoutEntity);
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        showToast = false;
                        showToastNotification = true;
                        self.presentationMode.wrappedValue.dismiss();
                    })
                })
            }
        }.toast(isPresenting: $showToast, duration: 2, offsetY: 50, alert: {
            AlertToast(displayMode: .hud, type: .loading, title: "Loading")
        })
        .navigationBarTitle(workoutName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
