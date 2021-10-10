//
//  DateExtension.swift
//  FitnessTracker
//
//  Created by Zaf on 10.10.21.
//

import Foundation

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded());
    }

    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000));
    }
}
