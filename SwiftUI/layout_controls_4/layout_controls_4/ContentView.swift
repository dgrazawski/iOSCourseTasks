//
//  ContentView.swift
//  layout_controls_4
//
//  Created by Dawid Grazawski on 06/08/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var isDark = false
    var body: some View {
        VStack {
            Toggle("Enable Dark Mode", isOn: $isDark)
                .toggleStyle(.myCustom)
        }
        .padding()
        .preferredColorScheme(isDark ? .dark : .light)
    }
}

struct MyCustomToggleStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            RoundedRectangle(cornerRadius: 25)
                .fill(configuration.isOn ? .purple : .cyan)
                .overlay {
                    Circle()
                        .fill(configuration.isOn ? .yellow : .white)
                        .shadow(radius: 1)
                        .padding(2)
                        .offset(x: configuration.isOn ? 10 : -10)
                }
                .frame(width: 50, height: 32)
                .onTapGesture {
                    withAnimation(.spring) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
    
    
}

extension ToggleStyle where Self == MyCustomToggleStyle {
    static var myCustom: MyCustomToggleStyle { .init() }
}

#Preview {
    ContentView()
}
