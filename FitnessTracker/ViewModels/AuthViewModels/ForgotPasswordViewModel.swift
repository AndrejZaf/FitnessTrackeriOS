//
//  ForgotPasswordViewModel.swift
//  FitnessTracker
//
//  Created by Zaf on 21.9.21.
//

import Foundation

class ForgotPasswordViewModel: ObservableObject {
    var email: String = "";
    @Published var successfulEmailSent: String = "";
    @Published var isFinished: Bool = false;
    
    func forgotPassword() -> Void {
        AuthService().forgotPassword(email: email) { result in
            switch result {
                case .success(let email):
                    DispatchQueue.main.async {
                        self.isFinished = true;
                        self.successfulEmailSent = email;
                    }
                case .failure(let error):
                    print(error);
            }
        }
    }
}
