//
//  PreferencesViewController.swift
//  Controllers
//
//  Created by Dawid Grazawski on 19/06/2025.
//

import UIKit

class PreferencesViewController: UIViewController {
    
    private let label = {
        let label = UILabel()
        label.text = "Notification preference: \(AppStorageClass["preference"] ?? "")"
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let changePreferencesButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        button.configuration = config
        button.setTitle("Change preference", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let confirmButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        button.configuration = config
        button.setTitle("Confirm", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(changePreferencesButton)
        view.addSubview(confirmButton)
        changePreferencesButton.addTarget(self, action: #selector(changePreferences), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmPreferences), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            changePreferencesButton.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            changePreferencesButton.heightAnchor.constraint(equalToConstant: 50),
            changePreferencesButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            changePreferencesButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
            label.topAnchor.constraint(equalTo: changePreferencesButton.bottomAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
            confirmButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40),
            confirmButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            confirmButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40)
        ])
    }
    
    @objc private func changePreferences() {
        let actionSheetController = UIAlertController(title: "Select Notification Preference", message: "", preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "Email Notifications", style: .default) { _ in
            self.label.text = "Notification preference: Email"
            AppStorageClass["preference"] = "Email"
        }
        
        let action2 = UIAlertAction(title: "SMS Notifications", style: .default) { _ in
            self.label.text = "Notification preference: SMS"
            AppStorageClass["preference"] = "SMS"
        }
        
        let action3 = UIAlertAction(title: "Push Notifications", style: .default) { _ in
            self.label.text = "Notification preference: Push"
            AppStorageClass["preference"] = "Push"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            
        }
        
        actionSheetController.addAction(action1)
        actionSheetController.addAction(action2)
        actionSheetController.addAction(action3)
        actionSheetController.addAction(cancelAction)
        
        present(actionSheetController, animated: true)
    }
    
    @objc private func confirmPreferences() {
        let confirmDetailsVC = ConfirmDetailsViewController()
        navigationController?.pushViewController(confirmDetailsVC, animated: true)
    }
}
