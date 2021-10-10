//
//  RegulatorService.swift
//  FitnessTracker
//
//  Created by Zaf on 9.10.21.
//

import Foundation

class RegulatorService {
    var semaphore: DispatchSemaphore;
    @Published var isAvailableToLoad: Bool = false;
    static let shared = RegulatorService();
    
    private init() {
        self.semaphore = DispatchSemaphore(value: 1);
        self.isAvailableToLoad = false;
    }
    
    func acquire() -> Void {
        self.semaphore.wait();
    }
    
    func release() -> Void {
        self.semaphore.signal();
    }
    
    func setAvailableToLoad(_ available: Bool) -> Void {
        isAvailableToLoad = available;
    }
}
