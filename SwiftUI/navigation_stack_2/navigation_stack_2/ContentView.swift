//
//  ContentView.swift
//  navigation_stack_2
//
//  Created by Dawid Grazawski on 12/08/2025.
//

import SwiftUI

enum NavigationEndpoint: Hashable {
   // case homeView
    case settingsView
    case profileView
}

struct ContentView: View {
    
    @State var path: [NavigationEndpoint] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            HomeView(path: $path)
                .navigationDestination(for: NavigationEndpoint.self) { destination in
                    switch destination {
                    case .settingsView:
                        SettingsView(path: $path)
                    case .profileView:
                        ProfileView(path: $path)
                    }
                }
        }
    }
}

struct HomeView: View {
    @Binding var path: [NavigationEndpoint]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Home View")
                .font(.largeTitle)
            Button("Go to Settings") {
                path.append(.settingsView)
            }
            .buttonStyle(.borderedProminent)
            .font(.title)
        }
        .padding()
    }
}

struct SettingsView: View {
    @Binding var path: [NavigationEndpoint]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Settings View")
                .font(.largeTitle)
            Button("Go to Profile") {
                path.append(.profileView)
            }
            .buttonStyle(.borderedProminent)
            .font(.title)
        }
        .padding()
    }
}

struct ProfileView: View {
    @Binding var path: [NavigationEndpoint]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Profile View")
                .font(.largeTitle)
            Button("Go to Home") {
                path.removeAll()
            }
            .buttonStyle(.borderedProminent)
            .font(.title)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
