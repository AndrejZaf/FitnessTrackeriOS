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
    @Published var isLoading: Bool = false;
    
    func forgotPassword() -> Void {
        self.isLoading = true;
        AuthService().forgotPassword(email: email) { result in
            switch result {
                case .success(let email):
                    DispatchQueue.main.async {
                        self.isFinished = true;
                        self.successfulEmailSent = email;
                        self.isLoading = false;
                    }
                case .failure(let error):
                    self.isLoading = false;
                    print(error);
            }
        }
    }
}
