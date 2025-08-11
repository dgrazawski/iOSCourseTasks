//
//  ContentView.swift
//  layout_modifiers_4
//
//  Created by Dawid Grazawski on 10/08/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Circle()
                .fill(.blue)
                .frame(width: 100, height: 100)
                .offset(x: -200, y: -370)
            Rectangle()
                .fill(.green)
                .frame(width: 100, height: 100)
                .offset(x: 20, y: 300)
        }
       // .frame(maxWidth: .infinity, maxHeight: .infinity)
       // .background(Color.red)
    }
}

#Preview {
    ContentView()
}
