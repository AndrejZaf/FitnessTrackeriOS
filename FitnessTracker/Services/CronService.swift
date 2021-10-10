//
//  CronService.swift
//  FitnessTracker
//
//  Created by Zaf on 10.10.21.
//

import Foundation
import SwiftCron;

struct CronService {
    let defaults = UserDefaults.standard;
    let queue = DispatchQueue(label: "cronQueue", attributes: .concurrent);
    
    func cronStart() {
        self.queue.async {
            let tokens = defaults.dictionary(forKey: "tokens");
            let accessToken = tokens!["accessToken"];
            // TODO Determine a correct value for a cron job every 30 minutes?
            let cron = Cron(frequency: 1800);
            let job = CronJob({
//                Repository.shared.deleteWorkouts();
                WorkoutService().getWorkouts(token: accessToken as! String);
            })

            cron.add(job);

            cron.start();
        }
        
    }
}


