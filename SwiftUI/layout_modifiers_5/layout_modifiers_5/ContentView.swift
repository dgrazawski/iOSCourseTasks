//
//  ContentView.swift
//  layout_modifiers_5
//
//  Created by Dawid Grazawski on 11/08/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("SwiftUI is amazing!")
                .font(.largeTitle)
                .background {
                    Rectangle()
                        .fill(.gray)
                }
                .overlay {
                    Circle()
                        .opacity(0.5)
                }
                .clipShape(.circle)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
