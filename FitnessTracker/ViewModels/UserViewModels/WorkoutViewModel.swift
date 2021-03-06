//
//  WorkoutViewModel.swift
//  FitnessTracker
//
//  Created by Zaf on 30.9.21.
//

import Foundation

class WorkoutViewModel: ObservableObject {
    @Published var listOfWorkouts = [WorkoutEntity]();
    
    init() {
        loadInitalList();
    }

    func loadInitalList() -> Void {
        print("Fetching new workouts")
        self.listOfWorkouts = Repository.shared.getWorkouts();
    }
    
    func search(search: String) -> Void {
        self.listOfWorkouts = Repository.shared.searchForWorkouts(workoutName: search);
    }
}
