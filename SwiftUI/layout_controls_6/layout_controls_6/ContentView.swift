//
//  ContentView.swift
//  layout_controls_6
//
//  Created by Dawid Grazawski on 06/08/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var groceries = [
        GroceryItemModel(name: "Caesar Salad", isEnabled: false),
        GroceryItemModel(name: "Orange Juice", isEnabled: true),
        GroceryItemModel(name: "Tomato", isEnabled: false),
        GroceryItemModel(name: "Potatoes", isEnabled: true),
        GroceryItemModel(name: "Red Bull", isEnabled: false),
        GroceryItemModel(name: "Ice cream", isEnabled: true)
    ]
    var body: some View {
        List {
            ForEach($groceries) { $grocery in
                HStack {
                    Text(grocery.name)
                    Spacer()
                    Toggle("Is enabled:", isOn: $grocery.isEnabled)
                        .frame(width: 140)
                }
            }
        }
    }
}

struct GroceryItemModel: Identifiable {
    let id = UUID()
    let name: String
    var isEnabled: Bool
}

#Preview {
    ContentView()
}
