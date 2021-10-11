//
//  HomeViewModel.swift
//  FitnessTracker
//
//  Created by Zaf on 26.9.21.
//

import Foundation

class HomeViewModel: ObservableObject {
    var listOfExercises = [ExerciseEntity]();
    var listOfWorkouts = [WorkoutEntity]();
    
    init() {
        getExercises();
        getWorkouts();
    }
    
    func getExercises() -> Void {
        listOfExercises = Repository.shared.getExercises(5);
    }
    
    func getWorkouts() -> Void {
        listOfWorkouts = Repository.shared.getWorkouts(numberOfWorkouts: 10);
    }
}
