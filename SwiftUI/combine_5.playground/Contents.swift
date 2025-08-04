import UIKit
import Combine

let typingQueue: [(String, TimeInterval)] = [
    ("H",0),
    ("He",0.25),
    ("Hel", 0.5),
    ("Hello", 0.75)
]
let intsSubject = PassthroughSubject<String, Never>()


let cancellable = intsSubject
    .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
    .sink { value in
        print(value)
    }


for type in typingQueue {
    DispatchQueue.main.asyncAfter(deadline: .now() + type.1) {
        intsSubject.send(type.0)
    }
}
