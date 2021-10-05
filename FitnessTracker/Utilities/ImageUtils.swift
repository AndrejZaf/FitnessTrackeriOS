//
//  ImageUtils.swift
//  FitnessTracker
//
//  Created by Zaf on 26.9.21.
//

import Foundation

class ImageUtils {
    
    func getImageForMuscleGroup(muscleGroup: String) -> String {
        switch muscleGroup {
        case "Abdominals":
            return "icons8-abs-50";
        case "Hamstrings":
            return "icons8-hamstrings-50";
        case "Quadriceps":
            return "icons8-quadriceps-50";
        case "Biceps":
            return "icons8-biceps-50";
        case "Shoulders", "Lats":
            return "icons8-shoulders-50";
        case "Chest":
            return "icons8-chest-50";
        case "Middle Back":
            return "icons8-middle-back-50";
        case "Calves":
            return "icons8-calves-50";
        case "Lower Back":
            return "icons8-lower-back-50";
        case "Triceps":
            return "icons8-triceps-50";
        case "Traps":
            return "icons8-trapezius-50";
        case "Forearms":
            return "icons8-forearm-50";
        case "Neck":
            return "icons8-neck-50";
        case "All":
            return "icons8-muscles-64";
        default:
            return "icons8-hamstrings-50";
        }
    }
}
