//
//  TextAndKeyboardVC.swift
//  notifications_task_2
//
//  Created by Dawid Grazawski on 21/07/2025.
//

import UIKit

class TextAndKeyboardVC: UIViewController {
    
    private lazy var lowConstraint = textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 600)
    private lazy var highConstraint = textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300)
    
    private let textField = {
        let textField = UITextField()
        textField.placeholder = "Enter the text here..."
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 20)
        textField.clearButtonMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        configureGesture()
        view.addSubview(textField)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NSLayoutConstraint.activate([
            lowConstraint,
            textField.heightAnchor.constraint(equalToConstant: 50),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    func configureGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        print("Keyboard is about to show")
        changeConstraints(isKeyboardVisible: true)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        print("Keyboard is about to hide")
        changeConstraints(isKeyboardVisible: false)
    }
    
    func changeConstraints(isKeyboardVisible: Bool) {
        switch isKeyboardVisible {
        case true:
            lowConstraint.isActive = false
            highConstraint.isActive = true
        case false:
            highConstraint.isActive = false
            lowConstraint.isActive = true
        }
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
}

