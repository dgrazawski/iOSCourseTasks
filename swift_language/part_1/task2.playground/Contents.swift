import Cocoa

public func isBalancedParentheses(input: String) -> Bool {
    var parenthesesCounter = 0
    for letter in input {
        if letter == "(" {
            parenthesesCounter += 1
        }
        else if letter == ")" {
            parenthesesCounter -= 1
        }
        if parenthesesCounter < 0 {
            return false
        }
    }
    return parenthesesCounter == 0
}
