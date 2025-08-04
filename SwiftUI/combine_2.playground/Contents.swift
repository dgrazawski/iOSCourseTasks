import UIKit
import Combine

let greeting = "Hello, Combine!"

var cancellables = Set<AnyCancellable>()

Future<String, Never> { promise in
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        promise(Result.success(greeting))
    }
}
.sink { value in
    print(value)
}
.store(in: &cancellables)
