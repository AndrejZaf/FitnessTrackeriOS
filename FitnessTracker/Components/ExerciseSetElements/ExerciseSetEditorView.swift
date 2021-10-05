//
//  ExerciseSetEditorView.swift
//  FitnessTracker
//
//  Created by Zaf on 1.10.21.
//

import SwiftUI

struct ExerciseSetEditorView: View {
    @State private var repSelection: Int = 1;
    @State private var weightSelection: Int = 1;
    @State private var restPeriodSelection: Int = 1;
    @Binding var exerciseSets: [SetEntity];
    @Binding var sheetShown: Bool;
    var body: some View {
        Form {
            Picker("Number of Repetitions", selection: $repSelection){
                ForEach(0 ..< 100) {
                    Text("\($0)")
                }
            }
            
            Picker("Weight", selection: $weightSelection){
                ForEach(0 ..< 1000) {
                    Text("\($0)kg")
                }
            }
            
            Picker("Rest Period in Seconds", selection: $restPeriodSelection){
                ForEach(0 ..< 100) {
                    Text("\($0)")
                }
            }
            Button(action: {
                exerciseSets.append(SetEntity(id: -1, reps: repSelection, weight: weightSelection, rest_period: restPeriodSelection, workout_exercise_id: -1));
                sheetShown.toggle();
            }, label: {
                Text("Save changes")
            })
        }
        
    }
}

//struct ExerciseSetEditorView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExerciseSetEditorView()
//    }
//}
