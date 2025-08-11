//
//  ContentView.swift
//  navigation_stack_1
//
//  Created by Dawid Grazawski on 11/08/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome")
                    .font(.largeTitle)
                NavigationLink {
                    SecondView()
                } label: {
                    Text("Navigation Button")
                        .font(.title)
                }
                .buttonStyle(.borderedProminent)

            }
            .padding()
        }
    }
}

struct SecondView: View {
    var body: some View {
        Text("Hello SwiftUI Navigation!")
            .font(.largeTitle)
            .navigationTitle("Second View")
    }
}

#Preview {
    ContentView()
}
