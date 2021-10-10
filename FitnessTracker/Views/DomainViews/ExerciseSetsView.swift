//
//  ExerciseSheetView.swift
//  FitnessTracker
//
//  Created by Zaf on 1.10.21.
//

import SwiftUI

struct ExerciseSetsView: View {
    @State var exerciseSets: [SetEntity];
    @State private var isSheetShown = false;
    @Binding var exercises: [WorkoutExerciseEntity];
    @State var exercise: ExerciseEntity;
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
                
                CustomButton(title: "Save", disabled: false, backgroundColor: .black, foregroundColor: .white, action: {
                    exercises.append(WorkoutExerciseEntity(id: -1, name: exercise.name, exercise_id: exercise.id, workout_id: -1, exerciseSets: exerciseSets))
                    self.presentationMode.wrappedValue.dismiss();
                })
            }
        }
        .bottomSheet(isPresented: $isSheetShown, height: 400, content: {
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

//struct ExerciseSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExerciseSetsView()
//    }
//}
