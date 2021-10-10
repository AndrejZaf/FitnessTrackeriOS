//
//  SecondaryExerciseSetsView.swift
//  FitnessTracker
//
//  Created by Zaf on 5.10.21.
//

import SwiftUI

struct SecondaryExerciseSetsView: View {
        @State var exerciseSets: [SetEntity];
        @State private var isSheetShown = false;
        @Binding var workoutExercise: WorkoutExerciseEntity;
        var exerciseName: String;
        var setType: SetType = SetType.View;
        @Environment(\.presentationMode) var presentationMode;
        
        var body: some View {
            VStack {
                ScrollView{
                    ForEach(0..<exerciseSets.count, id: \.self) { index in
                        ExerciseSetRowView(exerciseSet: exerciseSets[index], exerciseSets: $exerciseSets, indexSet: index, setType: SetType.Add).onTapGesture(perform: {
                            isSheetShown.toggle();
                        })
                    }
                }
                if setType == SetType.Add {
                    Spacer();
                    Button(action: {
                        workoutExercise.exerciseSets = exerciseSets;
                        self.presentationMode.wrappedValue.dismiss();
                    }, label: {
                        Text("Add exercise with sets")
                    })
                }
            }.bottomSheet(isPresented: $isSheetShown, height: 400, content: {
                ExerciseSetEditorView(exerciseSets: $exerciseSets, sheetShown: $isSheetShown);
            })
            .toolbar(content: {
                if setType == SetType.Add {
                    Button(action: {
                        isSheetShown.toggle();
                    }, label: {
                        Image(systemName: "plus");
                    })
                } else if setType == SetType.Edit {
                    Image(systemName: "slider.horizontal.3")
                }
            })
            .navigationBarTitle(exerciseName, displayMode: .inline);
        }
    }
