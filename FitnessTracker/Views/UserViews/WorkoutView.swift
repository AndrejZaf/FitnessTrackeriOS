//
//  WorkoutView.swift
//  FitnessTracker
//
//  Created by Zaf on 21.9.21.
//

import SwiftUI

struct WorkoutView: View {
    @StateObject private var workoutViewModel = WorkoutViewModel();
    @State private var searchState: String = "";
    @State private var workoutAdded: Bool = false;
    var body: some View {
        NavigationView {
            VStack{
                TextField("Search for a workout", text: $searchState)
                .textFieldStyle(CustomTextFieldStyle())
                    .padding(.horizontal)
                    .onChange(of: searchState, perform: { value in
                        workoutViewModel.search(search: searchState)
                    });
                
                VerticalWorkoutView(workouts: $workoutViewModel.listOfWorkouts, workoutAdded: $workoutAdded);
                Divider();
                HStack {
                    Spacer();
                    NavigationLink(
                        destination: CreateEditWorkoutView(showToastNotification: $workoutAdded),
                        label: {
                            Text("\(Image(systemName: "plus.circle"))")
                                .font(.title)
                        });
                    Spacer();
                }
                .padding(.vertical)
                Spacer();
            }
            .onAppear(perform: {
                    workoutViewModel.loadInitalList();
            })
            .toast(isPresenting: $workoutAdded, duration: 2, tapToDismiss: true, alert: {
                AlertToast(displayMode: .hud, type: .complete(Color.black), title: "Workout added");
            }, onTap: { workoutAdded = false }, completion: { workoutAdded = false } )
            .padding(.top)
            .navigationBarHidden(true);
        }.navigationViewStyle(StackNavigationViewStyle());
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
