//
//  ContentView.swift
//  state_management_4
//
//  Created by Dawid Grazawski on 14/08/2025.
//

import SwiftUI

@Observable
final class UserModel {
    var name: String
    var email: String
    
    init(name: String = "", email: String = "") {
        self.name = name
        self.email = email
    }
}

struct ContentView: View {
    @State private var user = UserModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(user.name)")
            Text("Email: \(user.email)")
            TextField("Name...", text: $user.name)
            TextField("Email...", text: $user.email)
        }
        .font(.title2)
        .textFieldStyle(.roundedBorder)
        .padding(20)
    }
}

#Preview {
    ContentView()
}
