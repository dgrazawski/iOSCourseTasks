//
//  ContentView.swift
//  controller_representable
//
//  Created by Dawid Grazawski on 19/08/2025.
//

import SwiftUI

struct MyRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let simpleVC = SimpleVC()
        return simpleVC
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    func sizeThatFits(_ proposal: ProposedViewSize, uiViewController: UIViewControllerType, context: Context) -> CGSize? {
        uiViewController.view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Hello from SwiftUI side!")
                .font(.title)
            Divider()
            MyRepresentable()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
