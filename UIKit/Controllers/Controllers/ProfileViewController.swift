//
//  ProfileViewController.swift
//  Controllers
//
//  Created by Dawid Grazawski on 16/06/2025.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let button = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        button.configuration = config
        button.setTitle("Edit profile", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let label = {
        let label = UILabel()
        label.text = "Default"
        label.font = .systemFont(ofSize: 40)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("🍏ProfileViewController: viewDidLoad()")
        view.addSubview(label)
        view.addSubview(button)
        
        configureButtons()
        configureConstraints()
    }
    
    private func configureButtons() {
        button.addTarget(self, action: #selector(moveToEdit), for: .touchUpInside)
        let editNameButton = UIBarButtonItem(image: UIImage(systemName: "pencil.slash"), style: .plain, target: self, action: #selector(editName))
        let anonymousNameButton = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.fill"), style: .plain, target: self, action: #selector(anonymousName))
        navigationItem.rightBarButtonItems = [editNameButton, anonymousNameButton]
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 25),
            
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            label.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    @objc private func moveToEdit(){
        let editVC = EditProfileViewController()
        editVC.title = "Edit profile"
        navigationController?.pushViewController(editVC, animated: true)
    }
    
    @objc private func editName(){
        let alertController = UIAlertController(title: "Edit name", message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.text = self.label.text
            textField.placeholder = "Name"
        }
        let submitAction = UIAlertAction(title: "OK", style: .default) { _ in
            if let text = alertController.textFields?.first?.text {
                if text.isEmpty {
                    self.label.text = "Default"
                } else {
                    self.label.text = text
                }
                
            }
        }
        alertController.addAction(submitAction)
        present(alertController, animated: true)
    }
    
    @objc private func anonymousName(){
        label.text = "Anonymous"
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            print("🍏ProfileViewController: viewWillAppear()")
        }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            print("🍏ProfileViewController: viewDidAppear()")
        }

        override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()
            print("🍏ProfileViewController: viewWillLayoutSubviews()")
        }

        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            print("🍏ProfileViewController: viewDidLayoutSubviews()")
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            print("🍏ProfileViewController: viewWillDisappear()")
        }

        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            print("🍏ProfileViewController: viewDidDisappear()")
        }
}
