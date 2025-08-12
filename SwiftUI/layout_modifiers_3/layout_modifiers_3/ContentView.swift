//
//  ContentView.swift
//  layout_modifiers_3
//
//  Created by Dawid Grazawski on 10/08/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(alignment: .lastTextBaseline, spacing: 20) {
            Text("Item 1")
                .font(.title)
            Text("Item 2")
                .font(.callout)
            Text("Item 3")
                .font(.largeTitle)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
