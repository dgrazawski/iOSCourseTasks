//
//  PersonalInfoViewController.swift
//  Controllers
//
//  Created by Dawid Grazawski on 17/06/2025.
//

import UIKit

class PersonalInfoViewController: UIViewController, UITextFieldDelegate {
    
    private let label = {
        let label = UILabel()
        label.text = "Personal information"
        label.font = .systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameTextField = {
        let textfield = UITextField()
        textfield.placeholder = "Name"
        textfield.borderStyle = .roundedRect
        textfield.font = .systemFont(ofSize: 20)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let phoneNumberTextField = {
        let textfield = UITextField()
        textfield.placeholder = "Phone number"
        textfield.borderStyle = .roundedRect
        textfield.font = .systemFont(ofSize: 20)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let confirmationButton = {
       let button = UIButton()
        button.setTitle("Confirm", for: .normal)
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        button.configuration = config
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(nameTextField)
        view.addSubview(phoneNumberTextField)
        view.addSubview(confirmationButton)
        //setupAlert()
        
       // present(alertController, animated: true, completion: nil)
        nameTextField.delegate = self
        phoneNumberTextField.delegate = self
        updateButtonStatus()
        confirmationButton.addTarget(self, action: #selector(confirmButtonAction), for: .touchUpInside)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            label.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
            
            nameTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),

            phoneNumberTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),

            confirmationButton.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 20),
            confirmationButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            confirmationButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func textFieldDidChangeSelection(_: UITextField) {
        updateButtonStatus()
    }
    
    private func setupAlert(){
        let alertController = UIAlertController(title: "Confirm Information", message: "Please confirm your name and phone number. Name: \(self.nameTextField.text ?? ""), Phone: \(self.phoneNumberTextField.text ?? "").", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) {_ in
            
        }
        
        let editAction = UIAlertAction(title: "Edit", style: .cancel) { _ in
            
        }
        alertController.addAction(confirmAction)
        alertController.addAction(editAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func updateButtonStatus(){
        guard let nameStatus = nameTextField.text?.isEmpty else { return }
        guard let phoneStatus = phoneNumberTextField.text?.count else { return }
        
        confirmationButton.isEnabled = !nameStatus && (phoneStatus >= 9)
    }
    
    @objc private func confirmButtonAction() {
        setupAlert()
        
    }
}
