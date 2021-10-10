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
    let queue = DispatchQueue(label: "queue", attributes: .concurrent);
    
    func cronStart() {
        self.queue.async {
            let tokens = defaults.dictionary(forKey: "tokens");
            let accessToken = tokens!["accessToken"];
            let cron = Cron(frequency: 180);
            let job = CronJob({
                WorkoutService().getWorkouts(token: accessToken as! String);
            })

            cron.add(job);

            cron.start();
        }
        
    }
}


