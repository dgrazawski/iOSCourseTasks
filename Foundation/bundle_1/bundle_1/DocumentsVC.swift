//
//  DocumentsVC.swift
//  bundle_1
//
//  Created by Dawid Grazawski on 23/07/2025.
//

import UIKit

class DocumentsVC: UIViewController {
    
    private let textView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 20)
        textView.layer.cornerRadius = 10
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let saveButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        button.configuration = config
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let loadButton = {
        let button = UIButton()
        button.setTitle("Load", for: .normal)
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        button.configuration = config
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        view.addSubview(textView)
        view.addSubview(saveButton)
        view.addSubview(loadButton)
        configureGesture()
        saveButton.addTarget(self, action: #selector(saveButtonTap), for: .touchUpInside)
        loadButton.addTarget(self, action: #selector(loadButtonTap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            textView.heightAnchor.constraint(equalToConstant: 300),
            
            saveButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            loadButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 20),
            loadButton.leadingAnchor.constraint(equalTo: saveButton.trailingAnchor, constant: 10),
            loadButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            saveButton.widthAnchor.constraint(equalTo: loadButton.widthAnchor)
        ])
    }
    
    @objc func saveButtonTap() {
        
    }
    
    @objc func loadButtonTap() {
        
    }

}


extension DocumentsVC {
    func configureGesture() {
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tap)
        }
        
        @objc func dismissKeyboard(){
            view.endEditing(true)
        }
}
