//
//  ContentView.swift
//  state_management_2
//
//  Created by Dawid Grazawski on 13/08/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var isOn = false
    var body: some View {
        VStack(spacing: 20) {
            Toggle("Show/hide text", isOn: $isOn)
                .font(.largeTitle)
            if isOn {
                Text("Hello, SwiftUI!")
                    .font(.largeTitle)
            }
                
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
