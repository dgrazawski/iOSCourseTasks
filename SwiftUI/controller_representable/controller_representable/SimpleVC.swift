//
//  SimpleVC.swift
//  controller_representable
//
//  Created by Dawid Grazawski on 19/08/2025.
//

import UIKit

class SimpleVC: UIViewController {
    
    private let label = {
        let label = UILabel()
        label.text = "Hello, from UIKit!"
        label.font = .preferredFont(forTextStyle: .title1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}
