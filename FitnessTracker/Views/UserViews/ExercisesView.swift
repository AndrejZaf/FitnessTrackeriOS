//
//  ExercisesView.swift
//  FitnessTracker
//
//  Created by Zaf on 21.9.21.
//

import SwiftUI

struct ExercisesView: View {
    @StateObject private var exercisesViewModel = ExerciseViewModel();
    @State private var searchState: String = "";
    @State private var selectedMuscleGroup: String = "All";
    var body: some View {
        NavigationView() {
            VStack{
                TextField("Search for an exercise", text: $searchState)
                    .textFieldStyle(CustomTextFieldStyle())
                    .padding(.horizontal)
                    .onChange(of: searchState, perform: { value in
                        selectedMuscleGroup = "All";
                        exercisesViewModel.searchByExerciseNameInitialLoad(exerciseName: searchState);
                    });
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(MuscleGroupUtils.muscleGroups.indices, id: \.self) { index in
                            ZStack {
                                Circle()
                                    .strokeBorder(Color.black, lineWidth: 2)
                                    .frame(width: 50, height: 50)
                                Image(ImageUtils().getImageForMuscleGroup(muscleGroup: MuscleGroupUtils.muscleGroups[index])).resizable()
                                    .frame(width: 35, height: 35);
                            }.onTapGesture {
                                searchState = "";
                                selectedMuscleGroup = MuscleGroupUtils.muscleGroups[index];
                                exercisesViewModel.loadInitialListPerMuscleGroup(muscleGroup: MuscleGroupUtils.muscleGroups[index]);
                            }
                        }.frame(height: 50)
                    }.padding(.vertical)
                }.padding(.horizontal);
                
                Divider();
                
                ScrollView{
                    LazyVStack{
                        ForEach(exercisesViewModel.listOfExercises.indices, id: \.self){ index in
                            ZStack {
                                NavigationLink(
                                    destination: ExerciseView(exercise: exercisesViewModel.listOfExercises[index]),
                                    label: {
                                        ExerciseRow(exercise: exercisesViewModel.listOfExercises[index])
                                            .onAppear(perform: {
                                                if index == exercisesViewModel.listOfExercises.count - 2 {
                                                    
                                                    if searchState != "" {
                                                        exercisesViewModel.searchMoreElementsByName(exerciseName: searchState)
                                                        return;
                                                    }
                                                    
                                                    if selectedMuscleGroup != "All" {
                                                        exercisesViewModel.loadMoreElementsPerGroup(muscleGroup: selectedMuscleGroup);
                                                    } else {
                                                        exercisesViewModel.loadMoreElements();
                                                    }
                                                }
                                            });
                                    })
                            }
                        }
                    }
                }
                Spacer();
            }
            .padding(.top)
            .navigationBarHidden(true);
        }.navigationViewStyle(StackNavigationViewStyle());
    }
}
