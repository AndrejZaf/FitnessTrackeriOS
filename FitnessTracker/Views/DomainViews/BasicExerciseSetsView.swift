//
//  BasicExerciseSetsView.swift
//  FitnessTracker
//
//  Created by Zaf on 5.10.21.
//

import SwiftUI

struct BasicExerciseSetsView: View {
    @Binding var exerciseSets: [SetEntity];
    @Binding var editMode: Bool;
    @State private var isSheetShown = false;
    var exerciseName: String;
    var setType: SetType = SetType.View;
    @Environment(\.presentationMode) var presentationMode;
    
    var body: some View {
        VStack {
            ScrollView{
                ForEach(0..<exerciseSets.count, id: \.self) { index in
                    if editMode {
                        ExerciseSetRowView(exerciseSet: exerciseSets[index], exerciseSets: $exerciseSets, indexSet: index, setType: SetType.Add).onTapGesture(perform: {
                            isSheetShown.toggle();
                        })
                    } else {
                        ExerciseSetRowView(exerciseSet: exerciseSets[index], exerciseSets: $exerciseSets, indexSet: index, setType: SetType.View).onTapGesture(perform: {
                            isSheetShown.toggle();
                        })
                    }
                    
                }
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
