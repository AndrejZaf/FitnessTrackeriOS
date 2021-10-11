//
//  CustomTextFieldStyle.swift
//  FitnessTracker
//
//  Created by Zaf on 20.9.21.
//

import Foundation;
import SwiftUI;

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
        .padding(15)
        .background(
            // Was corner radius 10
            RoundedRectangle(cornerRadius: 0, style: .continuous)
                .stroke(Color.secondary, lineWidth: 1)
        )
    }
}
