//
//  ContentView.swift
//  layout_modifiers_1
//
//  Created by Dawid Grazawski on 10/08/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("SwiftUI Layout Modifiers")
                .padding(16)
                .background(Color.green)
            Text("SwiftUI Layout Modifiers")
                .padding(.leading, 16)
                .background(Color.orange)
            Text("SwiftUI Layout Modifiers")
                .padding(.trailing, 16)
                .background(Color.red)
            Text("SwiftUI Layout Modifiers")
                .padding(.top, 16)
                .background(Color.yellow)
            Text("SwiftUI Layout Modifiers")
                .padding(.bottom, 16)
                .background(Color.cyan)
        }
    }
}

#Preview {
    ContentView()
}
