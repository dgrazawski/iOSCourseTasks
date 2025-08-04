import UIKit
import Combine

let intsSubject = PassthroughSubject<Int, Never>()


let cancellable = intsSubject
    .flatMap { Just($0 * $0) }
    .sink { print($0) }


for number in 0...10 {
    intsSubject.send(number)
}
