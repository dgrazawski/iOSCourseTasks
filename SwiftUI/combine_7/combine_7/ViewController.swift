//
//  ViewController.swift
//  combine_7
//
//  Created by Dawid Grazawski on 05/08/2025.
//

import UIKit

class ViewController: UIViewController {
    
    private let counterVM = CounterVM()
    
    private let counterButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tap Counter", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(counterButton)
        counterButton.addTarget(self, action: #selector(counterButtonTap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            counterButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            counterButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }

    @objc private func counterButtonTap(){
        counterVM.sendToCounter()
    }

}

