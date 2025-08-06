//
//  ContentView.swift
//  layout_controls_5
//
//  Created by Dawid Grazawski on 06/08/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            CardView(title: "Card 1") {
                Text("Body of card 1")
                Text("Second text of card 1")
            }
            CardView(title: "Card 2") {
                Button("Print to console") {
                    print("Actually prints to console")
                }
                .buttonStyle(.borderedProminent)
                Image(systemName: "plus")
            }
            CardView(title: "Card 3") {
                Circle()
                    .fill(.cyan)
                    .frame(width: 150, height: 150)
            }
        }
        .padding()
    }
}

struct CardView<Content: View>: View {
    var title: String
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(title)
                .font(.title)
                .padding()
            content()
                .padding()
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.gray ,lineWidth: 5)
        }
    }
}

#Preview {
    ContentView()
}
