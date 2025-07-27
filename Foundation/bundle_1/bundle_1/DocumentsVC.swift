//
//  DocumentsVC.swift
//  bundle_1
//
//  Created by Dawid Grazawski on 23/07/2025.
//

import UIKit

class DocumentsVC: UIViewController {
    
    private let fileName = "userNote1.txt"
    private let fileManager: FileManager = FileManager.default
    
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
        config.baseBackgroundColor = .green
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
    
    private let deleteButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        config.baseBackgroundColor = .red
        button.configuration = config
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let appendButton = {
        let button = UIButton()
        button.setTitle("Append", for: .normal)
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
        view.addSubview(deleteButton)
        view.addSubview(appendButton)
        
        configureGesture()
        
        saveButton.addTarget(self, action: #selector(saveButtonTap), for: .touchUpInside)
        loadButton.addTarget(self, action: #selector(loadButtonTap), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteButtonTap), for: .touchUpInside)
        appendButton.addTarget(self, action: #selector(appendButtonTap), for: .touchUpInside)
        
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
            
            saveButton.widthAnchor.constraint(equalTo: loadButton.widthAnchor),
            
            deleteButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 10),
            deleteButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            deleteButton.widthAnchor.constraint(equalTo: loadButton.widthAnchor),
            
            appendButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 10),
            appendButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            appendButton.widthAnchor.constraint(equalTo: loadButton.widthAnchor),
            
            
            
        ])
    }
    
    @objc func saveButtonTap() {
        saveButtonFunc()
    }
    
    @objc func loadButtonTap() {
        loadButtonFunc()
    }
    
    @objc func deleteButtonTap() {
        deleteButtonFunc()
    }
    
    @objc func appendButtonTap() {
        appendButtonFunc()
    }
    
    private func saveButtonFunc() {
        guard let text = textView.text, let fileURL = getFileURL() else { return }
        
        do {
            try text.write(to: fileURL, atomically: true, encoding: .utf8)
            showAlert(title: "Success", message: "Text saved.")
        } catch {
            showAlert(title: "Error", message: "Failed to save: \(error.localizedDescription)")
        }
    }
    
    private func loadButtonFunc() {
        guard let fileURL = getFileURL() else { return }
        
        do {
            let savedText = try String(contentsOf: fileURL, encoding: .utf8)
            textView.text = savedText
            showAlert(title: "Success", message: "Text loaded.")
        } catch {
            showAlert(title: "Error", message: "Failed to load: \(error.localizedDescription)")
        }
    }
    
    private func deleteButtonFunc() {
        guard let fileURL = getFileURL() else { return }
        
        if fileManager.fileExists(atPath: fileURL.path) {
            do {
                try fileManager.removeItem(at: fileURL)
                showAlert(title: "Deleted", message: "File deleted.")
                textView.text = ""
            } catch {
                showAlert(title: "Error", message: "Failed to delete: \(error.localizedDescription)")
            }
        } else {
            showAlert(title: "Not Found", message: "No file to delete.")
        }
    }
    
    private func appendButtonFunc() {
        guard let fileURL = getFileURL(), let text = textView.text else { return }
        
        if fileManager.fileExists(atPath: fileURL.path) {
            do {
                let fileHandle = try FileHandle(forWritingTo: fileURL)
                defer { fileHandle.closeFile() }
                
                fileHandle.seekToEndOfFile()
                if let data = ("\n" + text).data(using: .utf8) {
                    fileHandle.write(data)
                    showAlert(title: "Appended", message: "Text appended to the file.")
                }
            } catch {
                showAlert(title: "Error", message: "Failed to append: \(error.localizedDescription)")
            }
        } else {
            showAlert(title: "Not Found", message: "No file to append.")
        }
    }
    
}

extension DocumentsVC {
    func getDocumentDirectoryURL() -> URL? {
        fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    func getFileURL() -> URL? {
        return getDocumentDirectoryURL()?.appendingPathComponent(fileName)
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
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
