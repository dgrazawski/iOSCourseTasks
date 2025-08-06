//
//  ContentView.swift
//  layout_controls_1
//
//  Created by Dawid Grazawski on 06/08/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var isOn = false
    
    var body: some View {
        VStack {
            Toggle("Show Greeting", isOn: $isOn)
                .font(.title)
                .fontWeight(.thin)
            if isOn {
                Text("Hello, SwiftUI!")
                    .font(.largeTitle)
                    .fontWeight(.thin)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
