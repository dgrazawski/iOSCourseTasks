//
//  ContentView.swift
//  layout_controls_3
//
//  Created by Dawid Grazawski on 06/08/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(spacing: 20) {
            Circle()
                .foregroundStyle(.mint)
                .frame(maxWidth: 100, maxHeight: 100)
                .overlay {
                    Image(systemName: "person.fill")
                        .font(.system(size: 75))
                        .foregroundStyle(.gray)
                }
            VStack(alignment: .leading) {
                Text("John Doe")
                    .font(.largeTitle)
                Text("iOS Developer")
                    .font(.title)
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
