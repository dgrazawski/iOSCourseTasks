//
//  ContentView.swift
//  layout_modifiers_6
//
//  Created by Dawid Grazawski on 11/08/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isEnabled = true
    
    var body: some View {
        VStack {
            Toggle("Is Button enabled", isOn: $isEnabled)
                .font(.title)
                .padding()
            Button {
                print("Button Pressed")
            } label: {
                Text("Custom Button")
            }
            .buttonStyle(.myCustomButtonStyle(isEnabled: isEnabled))
            .disabled(!isEnabled)
            .padding()
            

        }
        .padding()
    }
}

struct MyCustomButtonStyle: ButtonStyle {
    let isEnabled: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title)
            .foregroundStyle(isEnabled ? Color.white : Color(.systemGray4))
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(isEnabled ? .green : .gray)
                    .opacity(configuration.isPressed ? 0.8 : 1)
            }
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}

extension ButtonStyle where Self == MyCustomButtonStyle {
    static func myCustomButtonStyle(isEnabled: Bool) -> MyCustomButtonStyle {
        MyCustomButtonStyle(isEnabled: isEnabled) }
}

#Preview {
    ContentView()
}
