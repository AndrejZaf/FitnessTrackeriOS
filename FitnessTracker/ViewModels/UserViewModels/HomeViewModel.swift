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
        listOfExercises = getExercises();
        listOfWorkouts = getWorkouts();
    }
    
    func getExercises() -> [ExerciseEntity] {
        return Repository.shared.getExercises(5);
    }
    
    func getWorkouts() -> [WorkoutEntity] {
        return Repository.shared.getWorkouts(numberOfWorkouts: 10);
    }
}
