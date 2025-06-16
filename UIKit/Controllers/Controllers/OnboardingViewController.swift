//
//  OnboardingViewController.swift
//  Controllers
//
//  Created by Dawid Grazawski on 16/06/2025.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private let button = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        button.configuration = config
        button.setTitle("Start", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        button.addTarget(self, action: #selector(pushButton), for: .touchUpInside)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
        ])
    }
    
    @objc private func pushButton() {
        let personalVC = PersonalInfoViewController()
        personalVC.title = "Personal Info"
        navigationController?.pushViewController(personalVC, animated: true)
        print("cos")
    }


}

