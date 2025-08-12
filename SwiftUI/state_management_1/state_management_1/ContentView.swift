//
//  ContentView.swift
//  state_management_1
//
//  Created by Dawid Grazawski on 13/08/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var counter = 0
    var body: some View {
        VStack(spacing: 20) {
            Text("Counter value: \(counter)")
                .font(.largeTitle)
            Button("+1") {
                counter += 1
            }
            .buttonStyle(.borderedProminent)
            .font(.largeTitle)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
