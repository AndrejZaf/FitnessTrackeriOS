//
//  VerticalExercisesScrollView.swift
//  FitnessTracker
//
//  Created by Zaf on 5.10.21.
//

import SwiftUI

struct VerticalExercisesScrollView: View {
    @StateObject private var createorEditWorkoutViewModel = CreateEditWorkoutViewModel();
    @Binding var exercises: [WorkoutExerciseEntity];
    @State private var searchState: String = "";
    var body: some View {
        VStack {
            TextField("Search for an exercise", text: $searchState)
                .textFieldStyle(CustomTextFieldStyle())
                .padding(.horizontal)
                .onChange(of: searchState, perform: { value in
                    createorEditWorkoutViewModel.searchByExerciseNameInitialLoad(exerciseName: searchState);
                });
            
            ScrollView{
                LazyVStack{
                    ForEach(createorEditWorkoutViewModel.listOfExercises.indices, id: \.self){ index in
                        HStack {
                            ExerciseSecondaryRow(exercise: createorEditWorkoutViewModel.listOfExercises[index])
                                .onAppear(perform: {
                                    if index == createorEditWorkoutViewModel.listOfExercises.count - 2 {
                                        if searchState != "" {
                                            createorEditWorkoutViewModel.searchMoreElementsByName(exerciseName: searchState)
                                            return;
                                        }
                                        
                                        createorEditWorkoutViewModel.loadMoreElements();
                                    }
                                });
                            Spacer();
                            NavigationLink(
                                // Bind a variable that will have the exercise and the sets
                                destination: ExerciseSetsView(exerciseSets: [], exercises: $exercises, exercise: createorEditWorkoutViewModel.listOfExercises[index], exerciseName: createorEditWorkoutViewModel.listOfExercises[index].name, setType: SetType.Add),
                                label: {
                                    if createorEditWorkoutViewModel.selectedExercises.contains(where: {$0.name == createorEditWorkoutViewModel.listOfExercises[index].name}) {
                                            Image(systemName: "minus.circle");
                                    } else {
                                        Image(systemName: "plus.circle");
                                    }
                                })
//                            Button(action: {
//                                if createorEditWorkoutViewModel.selectedExercises.contains(where: {$0.name == createorEditWorkoutViewModel.listOfExercises[index].name}) {
//                                    let index = createorEditWorkoutViewModel.selectedExercises.firstIndex(where: {$0.name == createorEditWorkoutViewModel.listOfExercises[index].name});
//                                    createorEditWorkoutViewModel.selectedExercises.remove(at: index!);
//                                } else {
//                                    createorEditWorkoutViewModel.selectedExercises.append(createorEditWorkoutViewModel.listOfExercises[index])
//                                    exercises.append(createorEditWorkoutViewModel.listOfExercises[index]);
//                                }
//                            }, label: {
//
//                            })
                            
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .padding(.top)
        .navigationBarTitle("", displayMode: .inline)
    }
}

//struct VerticalExercisesScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        VerticalExercisesScrollView()
//    }
//}
