//
//  ViewController.swift
//  ns_operation_queue_2
//
//  Created by Dawid Grazawski on 25/07/2025.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        testCase4()
    }
    
    
}


func testCase1() {
    let queue = OperationQueue()
    queue.maxConcurrentOperationCount = 6
    let operationA = createOperation(letter: "A")
    let operationB = createOperation(letter: "B")
    let operationC = createOperation(letter: "C")
    let operationD = createOperation(letter: "D")
    queue.addOperations([operationA, operationB, operationC, operationD], waitUntilFinished: false)
}

func testCase2() {
    let queue = OperationQueue()
    queue.maxConcurrentOperationCount = 2
    let operationA = createOperation(letter: "A")
    let operationB = createOperation(letter: "B")
    let operationC = createOperation(letter: "C")
    let operationD = createOperation(letter: "D")
    queue.addOperations([operationA, operationB, operationC, operationD], waitUntilFinished: false)
}

func testCase3() {
    let queue = OperationQueue()
    queue.maxConcurrentOperationCount = 2
    let operationA = createOperation(letter: "A")
    let operationB = createOperation(letter: "B")
    let operationC = createOperation(letter: "C")
    let operationD = createOperation(letter: "D")
    operationB.addDependency(operationC)
    operationD.addDependency(operationB)
    queue.addOperations([operationA, operationB, operationC, operationD], waitUntilFinished: false)
}

func testCase4() {
    let queue = OperationQueue()
    queue.maxConcurrentOperationCount = 6
    let operationA = createOperation(letter: "A")
    let operationB = createOperation(letter: "B")
    let operationC = createOperation(letter: "C")
    let operationD = createOperation(letter: "D")
//    operationB.addDependency(operationC)
//    operationD.addDependency(operationB)
    operationA.queuePriority = .low
    queue.addOperations([operationA, operationB, operationC, operationD], waitUntilFinished: false)
}

func createOperation(letter: String) -> BlockOperation {
    return BlockOperation {
        print("Operation \"\(letter)\" started") //  here use A, B, C, D depending on which operation you are configuring
        for _ in 0..<1000000 {
            // do nothing
        }
        print("Operation \"\(letter)\" finished") //  here use A, B, C, D depending on which operation you are configuring
    }
}

