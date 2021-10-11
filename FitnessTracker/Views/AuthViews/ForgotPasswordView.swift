//
//  ForgotPasswordView.swift
//  FitnessTracker
//
//  Created by Zaf on 20.9.21.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>;
    @StateObject private var forgotPasswordViewModel = ForgotPasswordViewModel();
    
    var body: some View {
        VStack {
            TextField("Email", text: $forgotPasswordViewModel.email)
                .textFieldStyle(CustomTextFieldStyle())
                .padding(.horizontal)
                .padding(.bottom);
            
            
            CustomButton(title: "Reset Password", disabled: false, backgroundColor: Color.black, foregroundColor: Color.white, action: {
                forgotPasswordViewModel.forgotPassword();
            }).alert(isPresented: Binding<Bool>(
                get: { forgotPasswordViewModel.isFinished }, set: {_ in }
            )) {
                Alert(title: Text("Email Sent"), message: Text("We sent an email to \(forgotPasswordViewModel.successfulEmailSent) with a link to get back into your account."), dismissButton: .default(Text("Ok"), action: {
                    self.mode.wrappedValue.dismiss();
                }));
            }
        }.toast(isPresenting: $forgotPasswordViewModel.isLoading, duration: 2, alert: { AlertToast(displayMode: .hud, type: .loading, title: "Loading") })
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
