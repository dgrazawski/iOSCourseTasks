import UIKit
import Combine

var cancellables = Set<AnyCancellable>()

let namePublisher = Just("Dawid")
    .map { $0.uppercased() }

let surnamePublisher = Just("Grazawski")
    .map { $0.lowercased() }


namePublisher
    .combineLatest(surnamePublisher)
    .sink { name, surname in
        print("\(name) \(surname)")
        
    }
    .store(in: &cancellables)
