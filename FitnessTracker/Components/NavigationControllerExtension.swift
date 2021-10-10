//
//  NavigationControllerExtension.swift
//  FitnessTracker
//
//  Created by Zaf on 10.10.21.
//

import Foundation
import SwiftUI;

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backButtonDisplayMode = .minimal;
    }
}
