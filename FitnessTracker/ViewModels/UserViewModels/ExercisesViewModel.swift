//
//  ExercisesViewModel.swift
//  FitnessTracker
//
//  Created by Zaf on 26.9.21.
//

import Foundation

class ExerciseViewModel: ObservableObject {
    @Published var listOfExercises = [ExerciseEntity]();
    private var offset = 0;
    private var totalElementsToLoad = 50;
    
    init() {
        loadInitalList();
    }
    
    func loadInitalList() -> Void {
        listOfExercises = Repository.shared.getExercises(offset: offset, numberOfExercises: totalElementsToLoad);
        offset += totalElementsToLoad;
    }
    
    func loadMoreElements() -> Void {
        let newElements = Repository.shared.getExercises(offset: offset, numberOfExercises: totalElementsToLoad);
        listOfExercises.append(contentsOf: newElements);
        offset += totalElementsToLoad;
    }
    
    func loadInitialListPerMuscleGroup(muscleGroup: String) -> Void {
        listOfExercises = [];
        offset = 0;
        listOfExercises = Repository.shared.getExercisePerGroup(muscleGroup: muscleGroup ,offset: offset, numberOfExercises: totalElementsToLoad);
        offset += totalElementsToLoad;
    }
    
    func loadMoreElementsPerGroup(muscleGroup: String) -> Void {
        let newElements = Repository.shared.getExercisePerGroup(muscleGroup: muscleGroup, offset: offset, numberOfExercises: totalElementsToLoad);
        listOfExercises.append(contentsOf: newElements);
        offset += totalElementsToLoad;
    }
    
    // Search for debounce implementation in Swift
    func searchByExerciseNameInitialLoad(exerciseName: String) -> Void{
        listOfExercises = [];
        offset = 0;
        listOfExercises = Repository.shared.searchForAnExerciseInitialLoad(exerciseName: exerciseName, offset: offset, numberOfExercises: totalElementsToLoad);
        offset += totalElementsToLoad;
    }
    
    func searchMoreElementsByName(exerciseName: String) -> Void {
        let newElements = Repository.shared.searchForAnExerciseInitialLoad(exerciseName: exerciseName, offset: offset, numberOfExercises: totalElementsToLoad);
        listOfExercises.append(contentsOf: newElements);
        offset += totalElementsToLoad;
    }
}
