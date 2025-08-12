//
//  ContentView.swift
//  state_management_3
//
//  Created by Dawid Grazawski on 13/08/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var isDark = false
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink("To the child view") {
                    SecondView(isDark: $isDark)
                }
                .font(.title)
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .preferredColorScheme(isDark ? .dark : .light)
        }
    }
}

struct SecondView: View {
    @Binding var isDark: Bool
    var body: some View {
        Toggle("Dark mode", isOn: $isDark)
            .padding()
    }
}

#Preview {
    ContentView()
}
