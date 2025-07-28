//
//  ViewController.swift
//  ns_operation_queue_3
//
//  Created by Dawid Grazawski on 28/07/2025.
//

import UIKit

class ViewController: UIViewController {
    
    private let testCase1Button = {
        let button = UIButton()
        button.setTitle("Test with dependencies", for: .normal)
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        button.configuration = config
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let testCase2Button = {
        let button = UIButton()
        button.setTitle("Test without dependencies", for: .normal)
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
        view.addSubview(testCase1Button)
        view.addSubview(testCase2Button)
        testCase1Button.addTarget(self, action: #selector(tapTest1), for: .touchUpInside)
        testCase2Button.addTarget(self, action: #selector(tapTest2), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            testCase1Button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            testCase1Button.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            testCase1Button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            testCase1Button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            testCase2Button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            testCase2Button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            testCase2Button.topAnchor.constraint(equalTo: testCase1Button.bottomAnchor, constant: 20)
            
        ])
    }
    
    @objc func tapTest1() {
        print("Testing with dependencies")
        test3WithDependencies()
    }
    
    @objc func tapTest2() {
        print("Testing without dependencies")
        test3WithoutDependencies()
    }
    
}

func test3WithDependencies() {
    let queue: OperationQueue = OperationQueue()
    let operationB: BlockOperation = BlockOperation {
        print("Operation \"B\" started") //  here use A, B depending on which operation you are configuring
        for _ in 0..<1000000 {
            // do nothing
        }
        print("Operation \"B\" finished") //  here use A, B depending on which operation you are configuring
    }
    let operationA: BlockOperation = BlockOperation {
        print("Operation \"A\" started") //  here use A, B depending on which operation you are configuring
        operationB.cancel()
        for _ in 0..<1000000 {
            // do nothing
        }
        print("Operation \"A\" finished") //  here use A, B depending on which operation you are configuring
    }
    operationB.addDependency(operationA)
    queue.addOperations([operationA, operationB], waitUntilFinished: false)
}

func test3WithoutDependencies() {
    let queue: OperationQueue = OperationQueue()
    let operationB: BlockOperation = BlockOperation {
        print("Operation \"B\" started") //  here use A, B depending on which operation you are configuring
        for _ in 0..<1000000 {
            // do nothing
        }
        print("Operation \"B\" finished") //  here use A, B depending on which operation you are configuring
    }
    let operationA: BlockOperation = BlockOperation {
        print("Operation \"A\" started") //  here use A, B depending on which operation you are configuring
        operationB.cancel()
        for _ in 0..<1000000 {
            // do nothing
        }
        print("Operation \"A\" finished") //  here use A, B depending on which operation you are configuring
    }
    queue.addOperations([operationA, operationB], waitUntilFinished: false)
}
