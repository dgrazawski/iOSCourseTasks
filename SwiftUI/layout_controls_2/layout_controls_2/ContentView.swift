//
//  ContentView.swift
//  layout_controls_2
//
//  Created by Dawid Grazawski on 06/08/2025.
//

import SwiftUI

struct ContentView: View {
    private var names = [ "James", "Tom", "Patrick", "Abraham", "Stanley"]
    var body: some View {
        List {
            ForEach(names, id: \.self) { name in
                HStack(spacing: 20) {
                    Text(name)
                    Spacer()
                    Button("Tap") {
                        print(name)
                    }
                    .buttonStyle(.borderedProminent)
                }
                
            }
        }
    }
}

#Preview {
    ContentView()
}
