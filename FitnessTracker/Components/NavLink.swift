//
//  NavLink.swift
//  FitnessTracker
//
//  Created by Zaf on 9.10.21.
//

import SwiftUI

struct NavLink<Content: View, Destination: View>: View {

    var destination: Destination
    var tag: String
    @Binding var selection: String?
    @ViewBuilder var content: Content

    var body: some View {
        Button(action: {
            selection = tag
        }, label: {
            ZStack {
                NavigationLink(destination: destination, tag: tag, selection: $selection) {
                    EmptyView()
                }
                .isDetailLink(true)
                content
            }
        })
    }
}
