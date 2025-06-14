//
//  Task3ViewController.swift
//  AutolatoutPracticalTasks
//
//  Created by Kakhaberi Kiknadze on 20.03.25.
//

import UIKit
import Combine

// Lay out login screen as in the attached screen recording.
// 1. Content should respect safe area guides
// 2. Content should be visible on all screen sizes
// 3. Content should be spaced on bottom as in the recording
// 4. When keyboard appears, content should move up
// 5. When you tap the screen and keyboard gets dismissed, content should move down
// 6. You can use container views/layout guides or any option you find useful
// 7. Content should have horizontal spacing of 16
// 8. Title and description labels should have a vertical spacing of 12 from each other
// 9. Textfields should have a spacing of 40 from top labels
// 10. Login button should have 16 spacing from textfields
final class Task3ViewController: UIViewController {
    private let titleLabel = UILabel()
    private let bodyLabel = UILabel()
    private let usernameField = UITextField()
    private let passwordField = UITextField()
    private let logInButton = UIButton()

    private let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupGestures()
    }
    
    private func setupGestures() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    @objc private func endEditing() {
        view.endEditing(true)
    }
    
    private func setupView() {
        setupContentView()
        setupLabels()
        setupTextFields()
        setupButton()
        setupConstraints()
    }
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
                //ContentView
                contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                contentView.bottomAnchor.constraint(lessThanOrEqualTo: view.keyboardLayoutGuide.topAnchor),
                contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

                //TitleLabel
                titleLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.layoutMarginsGuide.topAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),

                //BodyLabel
                bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
                bodyLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
                bodyLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),

                //UsernameField
                usernameField.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 40),
                usernameField.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
                usernameField.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),

                //PasswordField
                passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 16),
                passwordField.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
                passwordField.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),

                //LoginButton
                logInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 16),
                logInButton.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
                logInButton.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
                logInButton.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
            ])
    }
    
    private func setupContentView(){
       // contentView.backgroundColor = .cyan
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        view.addSubview(contentView)
        
    }
    
    private func setupLabels() {
        titleLabel.text = "Sign In"
        titleLabel.font = .boldSystemFont(ofSize: 32)
       // titleLabel.backgroundColor = .red
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        bodyLabel.numberOfLines = 3
        bodyLabel.text = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit,
        sed do eiusmod tempor incididunt ut labore
        """
      //  bodyLabel.backgroundColor = .yellow
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bodyLabel)
        
    }
    
    private func setupTextFields() {
        usernameField.placeholder = "Enter username"
        passwordField.placeholder = "Enter password"
        usernameField.borderStyle = .roundedRect
        passwordField.borderStyle = .roundedRect
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(usernameField)
        contentView.addSubview(passwordField)
        
    }
    
    private func setupButton() {
        logInButton.setTitle("Log In", for: .normal)
        logInButton.setTitleColor(.tintColor, for: .normal)
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(logInButton)
        
    }
}

#Preview {
    Task3ViewController()
}
