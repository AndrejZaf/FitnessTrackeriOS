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
        listOfWorkouts = Repository.shared.getWorkouts();
    }
    
}
