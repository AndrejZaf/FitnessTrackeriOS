//
//  BadgeView.swift
//  FitnessTracker
//
//  Created by Zaf on 26.9.21.
//

import SwiftUI

struct BadgeView: View {
    var text = "";
    var body: some View {
        Text(text)
            .foregroundColor(.black)
            .padding(3)
            .border(Color.gray)
            .cornerRadius(1)
            .font(.caption);
    }
}

struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeView(text: "Andrej")
    }
}
