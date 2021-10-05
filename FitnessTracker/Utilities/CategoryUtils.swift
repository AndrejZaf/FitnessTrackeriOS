//
//  CategoryUtils.swift
//  FitnessTracker
//
//  Created by Zaf on 26.9.21.
//

import Foundation

struct CategoryUtils {
    
    func determineCategory(category: String) -> String {
        if category == "Olympic_Weightlifting" {
            return "Olympic";
        }
        return category;
    }
}
