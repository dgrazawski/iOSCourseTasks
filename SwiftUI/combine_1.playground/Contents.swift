import UIKit
import Combine

let greeting = "Hello, Combine!"
var cancellables = Set<AnyCancellable>()

Just(greeting).sink { value in
    print(value)
}
.store(in: &cancellables)
