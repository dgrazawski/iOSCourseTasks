import UIKit
import Combine

//var cancellables = Set<AnyCancellable>()

let intsSubject = PassthroughSubject<Int, Never>()

let cancellable = intsSubject
    .filter { $0.isMultiple(of: 2) }
    .sink { print($0) }



for i in 0...15 {
    intsSubject.send(i)
}
