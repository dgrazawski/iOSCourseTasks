//
//  ViewController.swift
//  combine_8
//
//  Created by Dawid Grazawski on 05/08/2025.
//

import UIKit

class ViewController: UIViewController {

    private var toggleVM = ToggleVM()
    
    private let toggleButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tap to toggle", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(toggleButton)
        toggleButton.addTarget(self, action: #selector(toggleButtonTap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            toggleButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            toggleButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }

    @objc private func toggleButtonTap(){
        toggleVM.isLoading.toggle()
    }

}

