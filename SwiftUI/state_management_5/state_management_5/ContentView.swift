//
//  ContentView.swift
//  state_management_5
//
//  Created by Dawid Grazawski on 14/08/2025.
//

import SwiftUI

@Observable
final class FormModel {
    var username: String
    
    init(username: String = "") {
        self.username = username
    }
}

struct ContentView: View {
    @State private var form = FormModel()
    var body: some View {
        VStack {
            Form {
                TextField("Username...", text: $form.username)
                Button("Submit") {
                    print("Submit \(form.username)")
                }
                .disabled(form.username.isEmpty)
            }
        }
        .navigationTitle("Register")
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
