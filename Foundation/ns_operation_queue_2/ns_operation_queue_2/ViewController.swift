//
//  ViewController.swift
//  ns_operation_queue_2
//
//  Created by Dawid Grazawski on 25/07/2025.
//

import UIKit

class ViewController: UIViewController {
    
    private let testCase1Button = {
        let button = UIButton()
        button.setTitle("Case 1", for: .normal)
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        button.configuration = config
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let testCase2Button = {
        let button = UIButton()
        button.setTitle("Case 2", for: .normal)
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        button.configuration = config
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let testCase3Button = {
        let button = UIButton()
        button.setTitle("Case 3", for: .normal)
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        button.configuration = config
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let testCase4Button = {
        let button = UIButton()
        button.setTitle("Case 4", for: .normal)
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
        view.addSubview(testCase3Button)
        view.addSubview(testCase4Button)
        
        testCase1Button.addTarget(self, action: #selector(tapTest1), for: .touchUpInside)
        testCase2Button.addTarget(self, action: #selector(tapTest2), for: .touchUpInside)
        testCase3Button.addTarget(self, action: #selector(tapTest3), for: .touchUpInside)
        testCase4Button.addTarget(self, action: #selector(tapTest4), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            testCase1Button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            testCase1Button.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            testCase1Button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            testCase1Button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            testCase2Button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            testCase2Button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            testCase2Button.topAnchor.constraint(equalTo: testCase1Button.bottomAnchor, constant: 20),
            
            testCase3Button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            testCase3Button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            testCase3Button.topAnchor.constraint(equalTo: testCase2Button.bottomAnchor, constant: 20),
            
            testCase4Button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            testCase4Button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            testCase4Button.topAnchor.constraint(equalTo: testCase3Button.bottomAnchor, constant: 20)
            
        ])
    }
    
    @objc func tapTest1() {
        print("Testing case 1")
        let test = Test2()
        test.testCase1()
    }
    
    @objc func tapTest2() {
        print("Testing case 2")
        let test = Test2()
        test.testCase2()
    }
    
    @objc func tapTest3() {
        print("Testing case 3")
        let test = Test2()
        test.testCase3()
    }
    
    @objc func tapTest4() {
        print("Testing case 4")
        let test = Test2()
        test.testCase4()
    }
    
    
}

class Test2 {
    let queue: OperationQueue
    let operationA: BlockOperation
    let operationB: BlockOperation
    let operationC: BlockOperation
    let operationD: BlockOperation
    
    init() {
        self.queue = OperationQueue()
        self.operationA = Test2.createOperation(letter: "A")
        self.operationB = Test2.createOperation(letter: "B")
        self.operationC = Test2.createOperation(letter: "C")
        self.operationD = Test2.createOperation(letter: "D")
    }
    static func createOperation(letter: String) -> BlockOperation {
        return BlockOperation {
            print("Operation \"\(letter)\" started") //  here use A, B, C, D depending on which operation you are configuring
            for _ in 0..<1000000 {
                // do nothing
            }
            print("Operation \"\(letter)\" finished") //  here use A, B, C, D depending on which operation you are configuring
        }
    }
    
    func testCase1() {
        queue.maxConcurrentOperationCount = 6
        queue.addOperations([operationA, operationB, operationC, operationD], waitUntilFinished: false)
    }
    
    func testCase2() {
        queue.maxConcurrentOperationCount = 2
        queue.addOperations([operationA, operationB, operationC, operationD], waitUntilFinished: false)
    }
    
    func testCase3() {
        operationB.addDependency(operationC)
        operationD.addDependency(operationB)
        queue.addOperations([operationA, operationB, operationC, operationD], waitUntilFinished: false)
    }
    
    func testCase4() {
        operationB.addDependency(operationC)
        operationD.addDependency(operationB)
        operationA.queuePriority = .low
        queue.addOperations([operationA, operationB, operationC, operationD], waitUntilFinished: false)
    }
}


//func testCase1() {
//    let queue = OperationQueue()
//    queue.maxConcurrentOperationCount = 6
//    let operationA = createOperation(letter: "A")
//    let operationB = createOperation(letter: "B")
//    let operationC = createOperation(letter: "C")
//    let operationD = createOperation(letter: "D")
//    queue.addOperations([operationA, operationB, operationC, operationD], waitUntilFinished: false)
//}
//
//func testCase2() {
//    let queue = OperationQueue()
//    queue.maxConcurrentOperationCount = 2
//    let operationA = createOperation(letter: "A")
//    let operationB = createOperation(letter: "B")
//    let operationC = createOperation(letter: "C")
//    let operationD = createOperation(letter: "D")
//    queue.addOperations([operationA, operationB, operationC, operationD], waitUntilFinished: false)
//}
//
//func testCase3() {
//    let queue = OperationQueue()
//    let operationA = createOperation(letter: "A")
//    let operationB = createOperation(letter: "B")
//    let operationC = createOperation(letter: "C")
//    let operationD = createOperation(letter: "D")
//    operationB.addDependency(operationC)
//    operationD.addDependency(operationB)
//    queue.addOperations([operationA, operationB, operationC, operationD], waitUntilFinished: false)
//}
//
//func testCase4() {
//    let queue = OperationQueue()
//    let operationA = createOperation(letter: "A")
//    let operationB = createOperation(letter: "B")
//    let operationC = createOperation(letter: "C")
//    let operationD = createOperation(letter: "D")
//    operationB.addDependency(operationC)
//    operationD.addDependency(operationB)
//    operationA.queuePriority = .low
//    queue.addOperations([operationA, operationB, operationC, operationD], waitUntilFinished: false)
//}
//
//func createOperation(letter: String) -> BlockOperation {
//    return BlockOperation {
//        print("Operation \"\(letter)\" started") //  here use A, B, C, D depending on which operation you are configuring
//        for _ in 0..<1000000 {
//            // do nothing
//        }
//        print("Operation \"\(letter)\" finished") //  here use A, B, C, D depending on which operation you are configuring
//    }
//}

