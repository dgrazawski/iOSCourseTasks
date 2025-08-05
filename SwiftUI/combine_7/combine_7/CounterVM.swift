//
//  CounterVM.swift
//  combine_7
//
//  Created by Dawid Grazawski on 05/08/2025.
//

import Foundation
import Combine


class CounterVM {
    private let buttonSubject = PassthroughSubject<Void,Never>()
    
    private var counter = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addObserverToCounter()
    }
    
    private func addObserverToCounter() {
        buttonSubject
            .sink { [weak self] in
                guard let self = self else { return }
                counter += 1
                print("Counter of button taps: \(counter)")
            }
            .store(in: &cancellables)
    }
    
    func sendToCounter() {
        buttonSubject.send()
    }
}
