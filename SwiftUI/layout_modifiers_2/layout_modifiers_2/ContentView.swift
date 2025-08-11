//
//  ContentView.swift
//  layout_modifiers_2
//
//  Created by Dawid Grazawski on 10/08/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .fill(Color.red)
                .frame(width: 150, height: 100)
//                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            Rectangle()
                .fill(Color.blue)
                .frame(width: 150, height: 100)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      //  .padding()
        .ignoresSafeArea()
        //.background(Color.green)
      //  .border(Color.green)
    }
}

#Preview {
    ContentView()
}
