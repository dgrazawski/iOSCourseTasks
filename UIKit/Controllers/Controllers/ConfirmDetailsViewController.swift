//
//  ConfirmDetailsViewController.swift
//  Controllers
//
//  Created by Dawid Grazawski on 19/06/2025.
//

import UIKit

class ConfirmDetailsViewController: UIViewController {
    
    private let nameLabel = {
        let label = UILabel()
        label.text = "Name: \(AppStorageClass["name"] ?? "")"
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let phoneNumberLabel = {
        let label = UILabel()
        label.text = "Phone number: \(AppStorageClass["phone"] ?? "")"
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let notificationPreferenceLabel = {
        let label = UILabel()
        label.text = "Notification Preference: \(AppStorageClass["preference"] ?? "") Notifications"
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let startOverButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        button.configuration = config
        button.setTitle("Start over", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let editPreferencesButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        button.configuration = config
        button.setTitle("Edit preferences", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let editPersonalInfoButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        button.configuration = config
        button.setTitle("Edit personal info", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let confirmButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        button.configuration = config
        button.setTitle("OK", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        view.backgroundColor = .white
        
        view.addSubview(nameLabel)
        view.addSubview(phoneNumberLabel)
        view.addSubview(notificationPreferenceLabel)
        view.addSubview(startOverButton)
        view.addSubview(editPreferencesButton)
        view.addSubview(editPersonalInfoButton)
        view.addSubview(confirmButton)
        
        setupButtons()
        setupConstraints()
    }
    
    private func setupButtons() {
        startOverButton.addTarget(self, action: #selector(startOverAction), for: .touchUpInside)
        editPreferencesButton.addTarget(self, action: #selector(editPreferencesAction), for: .touchUpInside)
        editPersonalInfoButton.addTarget(self, action: #selector(editPersonalInfoAction), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
            phoneNumberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
            notificationPreferenceLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 20),
            notificationPreferenceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            notificationPreferenceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
            startOverButton.topAnchor.constraint(equalTo: notificationPreferenceLabel.bottomAnchor, constant: 40),
            startOverButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            startOverButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
            editPreferencesButton.topAnchor.constraint(equalTo: startOverButton.bottomAnchor, constant: 20),
            editPreferencesButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            editPreferencesButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
            editPersonalInfoButton.topAnchor.constraint(equalTo: editPreferencesButton.bottomAnchor, constant: 20),
            editPersonalInfoButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            editPersonalInfoButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
            confirmButton.topAnchor.constraint(equalTo: editPersonalInfoButton.bottomAnchor, constant: 40),
            confirmButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            confirmButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            confirmButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])
    }
    
    @objc private func startOverAction(){
        AppStorageClass["name"] = nil
        AppStorageClass["phone"] = nil
        AppStorageClass["preference"] = nil
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func editPersonalInfoAction(){
        guard let controller = navigationController?.viewControllers.first(where: {$0 is PersonalInfoViewController}) else { return }
        navigationController?.popToViewController(controller, animated: true)
    }
    
    @objc private func editPreferencesAction(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func confirmAction(){
        guard let controller = navigationController?.viewControllers.first else { return }
        if let controller = controller as? OnboardingViewController {
            controller.changeButton()
        }
        navigationController?.popToRootViewController(animated: true)
    }
}
