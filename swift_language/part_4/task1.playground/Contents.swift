import Cocoa

class Stack<T> {
    private var items: [T] = []
    
    func push(_ element: T) {
        items.append(element)
    }
    
    func pop() -> T? {
        return items.popLast()
    }
    
    func size() -> Int {
        return items.count
    }
    
}


func printStackContents<T>(_ stack: Stack<T>) -> String {
    var secondStack = Stack<T>()
    var contentsString = ""
    
    while let head = stack.pop() {
        contentsString += "\(head) \n"
        secondStack.push(head)
    }
    
    while let secondHead = secondStack.pop() {
        stack.push(secondHead)
    }
    return contentsString
}

let stack1 = Stack<String>()
stack1.push("One")
stack1.push("Two")

print(printStackContents(stack1))
print(stack1.size())
print(stack1.pop() as Any)
print(stack1.size())
