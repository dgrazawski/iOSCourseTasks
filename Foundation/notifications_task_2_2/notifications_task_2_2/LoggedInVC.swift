//
//  LoggedInVC.swift
//  notifications_task_2_2
//
//  Created by Dawid Grazawski on 23/07/2025.
//

import UIKit

class LoggedInVC: UIViewController {
    
    private let emailLabel = {
        let label = UILabel()
        label.text = "Logged as: "
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let logOutButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        button.configuration = config
        button.setTitle("Log Out", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(emailLabel)
        view.addSubview(logOutButton)
        logOutButton.addTarget(self, action: #selector(logOutFunc), for: .touchUpInside)
        setupLabel()
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            emailLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            logOutButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            logOutButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            logOutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    func setupLabel() {
        guard let emailText = UserDefaults.standard.string(forKey: "email") else { return }
        emailLabel.text = "Logged as: \(emailText)"
    }
    
    @objc func logOutFunc() {
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()
        guard let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate else { return }
        sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: LoginVC())
    }
}
