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


//let testCases = [
//    ("()", true),
//    ("(())", true),
//    ("()()", true),
//    ("abc(def)ghi", true),
//    ("((a)b(c))", true),
//    ("", true),
//    ("(", false),
//    (")", false),
//    ("(()", false),
//    ("())", false),
//    ("(()))(()", false),
//    (")abc(", false),
//    ("abc", true),
//    ("(((((((((())))))))))", true),
//    ("(()()())())(()))", false),
//    (")(", false),
//    (")()(",false)
//]
//
//for (input, expected) in testCases {
//    let result = isBalancedParentheses(input: input)
//    print("Input: \(input) → Result: \(result) → \(result == expected ? "✅" : "❌ Expected: \(expected)")")
//}
