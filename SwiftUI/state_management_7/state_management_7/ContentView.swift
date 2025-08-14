//
//  ContentView.swift
//  state_management_7
//
//  Created by Dawid Grazawski on 14/08/2025.
//

import SwiftUI

@Observable
final class SharedCounter {
    private(set) var counter = 0
    
    func incrementCounter() {
        counter += 1
    }
}

struct ContentView: View {
    @State private var sharedCounter = SharedCounter()
    var body: some View {
        VStack(spacing: 20) {
            ChildView(sharedCounter: sharedCounter, title: "First view")
            Divider()
            ChildView(sharedCounter: sharedCounter, title: "Second view")
        }
        .padding()
        .navigationTitle("Counter view")
    }
}

struct ChildView: View {
    @Bindable var sharedCounter: SharedCounter
    let title: String
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.largeTitle)
            Text("\(sharedCounter.counter)")
            Button("+1") {
                sharedCounter.incrementCounter()
            }
            .buttonStyle(.borderedProminent)
        }
        .font(.title)
    }
}


#Preview {
    NavigationStack {
        ContentView()
    }
}
