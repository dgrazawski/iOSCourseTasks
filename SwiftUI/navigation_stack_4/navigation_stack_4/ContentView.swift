//
//  ContentView.swift
//  navigation_stack_4
//
//  Created by Dawid Grazawski on 12/08/2025.
//

import SwiftUI

enum Destination: Hashable {
    case settingsView
}

struct ContentView: View {
    @State var path: [Destination] = []
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Text("Main screen of the app")
                    .font(.largeTitle)
            }
            .navigationTitle("My App")
            .toolbarBackground(.blue, for: .navigationBar)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        path.append(.settingsView)
                    } label: {
                        Image(systemName: "gear")
                            .foregroundStyle(.white)
                    }
                    
                }
            }
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .settingsView:
                    SettingsView(path: $path)
                }
            }
        }
    }
}

struct SettingsView: View {
    @Binding var path: [Destination]
    var body: some View {
        VStack {
            Text("Settings view!")
                .font(.largeTitle)
            Button("Back") {
                _ = path.popLast()
            }
            .buttonStyle(.borderedProminent)
            .font(.title)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ContentView()
}
