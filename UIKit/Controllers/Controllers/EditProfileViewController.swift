//
//  EditProfileViewController.swift
//  Controllers
//
//  Created by Dawid Grazawski on 17/06/2025.
//

import UIKit

class EditProfileViewController: UIViewController {
    let label = {
        let label = UILabel()
        label.text = "Label for visualization"
        label.font = .systemFont(ofSize: 25)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("🍎EditProfileViewController: viewDidLoad()")
        view.backgroundColor = .white
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            label.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -20)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            print("🍎EditProfileViewController: viewWillAppear()")
        }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            print("🍎EditProfileViewController: viewDidAppear()")
        }

        override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()
            print("🍎EditProfileViewController: viewWillLayoutSubviews()")
        }

        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            print("🍎EditProfileViewController: viewDidLayoutSubviews()")
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            print("🍎EditProfileViewController: viewWillDisappear()")
        }

        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            print("🍎EditProfileViewController: viewDidDisappear()")
        }
    
    
}
