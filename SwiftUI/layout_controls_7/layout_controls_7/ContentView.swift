//
//  ContentView.swift
//  layout_controls_7
//
//  Created by Dawid Grazawski on 07/08/2025.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack {
            ProfileDetailView(user: User(name: "Dawid", age: 32, location: "Poznań", isPremium: true) )
            ProfileDetailView(user: User(name: "Jeremy", age: 45, location: "Warszawa", isPremium: false) )
        }
        .padding()
    }
}

struct User: Identifiable {
    let id = UUID()
    let name: String
    let age: Int
    let location: String
    let isPremium: Bool
    
}

struct ProfileDetailView: View {
    
    var user: User
    
    var body: some View {
        
        VStack(spacing: 20) {

            ZStack(alignment: .topTrailing) {
                
                Circle()
                    .fill(Color(.systemGray2))
                    .frame(width: 150, height: 150)
                    .overlay {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(Color(.systemGray5))
                    }
                
                if user.isPremium {
                    Label("Premium", systemImage: "checkmark.seal.fill")
                        .font(.subheadline)
                        .padding(6)
                        .background(Color(.teal))
                        .clipShape(Capsule())
                        .offset(x: 40, y: -10)
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Name:")
                        .fontWeight(.bold)
                    Text(user.name)
                }
                
                HStack {
                    Text("Age:")
                        .fontWeight(.bold)
                    Text("\(user.age)")
                }
                
                HStack {
                    Text("Location:")
                        .fontWeight(.bold)
                    Text(user.location)
                }
            }
            .font(.title2)
            .padding()
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
