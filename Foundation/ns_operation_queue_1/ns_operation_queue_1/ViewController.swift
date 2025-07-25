//
//  ViewController.swift
//  ns_operation_queue_1
//
//  Created by Dawid Grazawski on 25/07/2025.
//

import UIKit

class ViewController: UIViewController {
    
   // private let task1 = Task1()
    
    private let addToMainButton = {
        let button = UIButton()
        button.setTitle("Add to Main Queue", for: .normal)
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        button.configuration = config
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let addToCustomButton = {
        let button = UIButton()
        button.setTitle("Add to custom Queue", for: .normal)
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
        view.addSubview(addToMainButton)
        view.addSubview(addToCustomButton)
        
        NSLayoutConstraint.activate([
            addToMainButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            addToMainButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            addToMainButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            addToMainButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            addToCustomButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            addToCustomButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addToCustomButton.topAnchor.constraint(equalTo: addToMainButton.bottomAnchor, constant: 20)
            
        ])
        addToMainButton.addTarget(self, action: #selector(addToMainFunc), for: .touchUpInside)
        addToCustomButton.addTarget(self, action: #selector(addToCustomFunc), for: .touchUpInside)
    }
    
    @objc func addToMainFunc() {
        print("Adding to Main Func run")
        let task1 = Task1()
        task1.addToQueueMain()
    }
    
    @objc func addToCustomFunc() {
        print("Adding to Custom Func run")
        let task1 = Task1()
        task1.addToCustomQueue()
    }

}


class Task1 {
    let queue = OperationQueue()
    let operation = BlockOperation {
        print("Operation \"A\" started")
        for _ in 0..<1000000 {
            // do nothing
        }
        print("Operation \"A\" finished")
    }
    
    func addToQueueMain() {
        OperationQueue.main.addOperation(operation)
    }
    
    func addToCustomQueue() {
        queue.addOperation(operation)
    }
}
