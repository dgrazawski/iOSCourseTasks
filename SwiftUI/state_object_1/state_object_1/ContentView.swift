//
//  ContentView.swift
//  state_object_1
//
//  Created by Dawid Grazawski on 17/08/2025.
//

import SwiftUI

final class Counter: ObservableObject {
    @Published private(set) var counterValue: Int = 0
    
    func incrementCounter() {
        counterValue += 1
    }
    
    func decrementCounter() {
        counterValue -= 1
    }
}

struct ContentView: View {
    @StateObject private var counter = Counter()
    var body: some View {
        VStack(spacing: 20) {
            CounterDisplayView()
            HStack(spacing: 20) {
                IncrementCounterView()
                DecrementCounterView()
            }
        }
        .padding()
        .environmentObject(counter)
    }
}

struct CounterDisplayView: View {
    @EnvironmentObject var counter: Counter
    var body: some View {
        Text("Counter value: \(counter.counterValue)")
            .font(.largeTitle)
    }
}

struct IncrementCounterView: View {
    @EnvironmentObject var counter: Counter
    var body: some View {
        Button {
            counter.incrementCounter()
        } label: {
            Label("Increment", systemImage: "plus")
        }
        .buttonStyle(.borderedProminent)

    }
}

struct DecrementCounterView: View {
    @EnvironmentObject var counter: Counter
    var body: some View {
        Button {
            counter.decrementCounter()
        } label: {
            Label("Decrement", systemImage: "minus")
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    ContentView()
}
