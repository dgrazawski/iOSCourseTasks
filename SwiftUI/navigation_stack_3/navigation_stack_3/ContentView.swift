//
//  ContentView.swift
//  navigation_stack_3
//
//  Created by Dawid Grazawski on 12/08/2025.
//

import SwiftUI

struct ListItem: Identifiable {
    let id: UUID = UUID()
    let name: String
    let details: String
}

struct ContentView: View {
    var items = [
        ListItem(name: "Banana", details: "Banana is yellow and grows on tree like something i believe."),
        ListItem(name: "Cherry", details: "Cherries grow on trees, are usually red and for some people tasty."),
        ListItem(name: "Apple", details: "Apple can be in different colors and grow on trees. Yo can make an apple pie from them."),
        ListItem(name: "Blueberry", details: "Blueberries are dark blue color and grow on the bushes?")
        
    ]
    var body: some View {
        NavigationStack {
            List(items) { item in
                NavigationLink {
                    DetailView(item: item)
                } label: {
                    Text(item.name)
                }

            }
            .navigationTitle("List of items")
        }
    }
}

struct DetailView: View {
    @State var isPresented = false
    var item: ListItem
    var body: some View {
        VStack(spacing: 20) {
            Text(item.name)
                .font(.largeTitle)
            Button("\(item.name) details") {
                isPresented.toggle()
            }
            .buttonStyle(.borderedProminent)
            .font(.title)
        }.sheet(isPresented: $isPresented) {
            DetailSheetView(item: item)
                .presentationDetents([.medium, .large])
                .presentationBackgroundInteraction(.enabled)
        }
    }
}

struct DetailSheetView: View {
    @Environment(\.dismiss) private var dismiss
    var item: ListItem
    var body: some View {
        VStack(spacing: 10) {
            Text(item.name)
            Text("Details of an item: \(item.details)")
            Button("Done") {
                dismiss()
            }
            .foregroundStyle(.red)
            .font(.title)
        }
    }
}

#Preview {
    ContentView()
}
