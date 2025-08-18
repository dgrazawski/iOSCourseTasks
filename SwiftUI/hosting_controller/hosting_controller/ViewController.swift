//
//  ViewController.swift
//  hosting_controller
//
//  Created by Dawid Grazawski on 19/08/2025.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    private let button = {
        let button = UIButton()
        var config = UIButton.Configuration.borderedProminent()
        button.configuration = config
        button.setTitle("Navigate to SwiftUI", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(button)
        button.addTarget(self, action: #selector(navigateToSwiftUI), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40)
        ])
    }
    
    
    @objc private func navigateToSwiftUI() {
        let hostController = UIHostingController(rootView: SwiftUIView())
        hostController.title = "SwiftUI View"
        navigationController?.pushViewController(hostController, animated: true)
    }
    
}

