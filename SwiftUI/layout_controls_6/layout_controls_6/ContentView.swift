//
//  ContentView.swift
//  layout_controls_6
//
//  Created by Dawid Grazawski on 06/08/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var groceries = [
        GroceryItemModel(name: "Salad", isEnabled: false),
        GroceryItemModel(name: "Orange Juice", isEnabled: true),
        GroceryItemModel(name: "Tomato", isEnabled: false),
        GroceryItemModel(name: "Potatoes", isEnabled: true)
    ]
    var body: some View {
        List {
            ForEach(groceries.indices, id: \.self) { index in
                HStack {
                    Text(groceries[index].name)
                    Spacer()
                    Toggle("Is enabled:", isOn: $groceries[index].isEnabled)
                        .frame(width: 140)
                }
            }
        }
    }
}

struct GroceryItemModel: Identifiable, Hashable {
    let id = UUID()
    let name: String
    var isEnabled: Bool
}

#Preview {
    ContentView()
}
