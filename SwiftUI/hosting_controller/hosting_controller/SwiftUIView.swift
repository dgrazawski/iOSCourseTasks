//
//  SwiftUIView.swift
//  hosting_controller
//
//  Created by Dawid Grazawski on 19/08/2025.
//

import SwiftUI

struct SwiftUIView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 20) {
            Text("This view is from SwiftUI")
                .font(.title)
            Button("Dismiss View") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    SwiftUIView()
}
