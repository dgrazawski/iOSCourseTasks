//
//  ToggleVM.swift
//  combine_8
//
//  Created by Dawid Grazawski on 05/08/2025.
//

import Foundation
import Combine

class ToggleVM {
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        observeIsLoading()
    }
    
    private func observeIsLoading() {
        $isLoading
            .sink { value in
                print("Loading state changed to: \(value)")
            }
            .store(in: &cancellables)
    }
}
