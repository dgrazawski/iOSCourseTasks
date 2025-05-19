import Cocoa

public func isPalindrome(input: String) -> Bool {
    
    var filtered = input.filter{
        $0.isLetter
    }.lowercased()
    if filtered.count < 2 {
        return false
    }
    if filtered == String(filtered.reversed()){
        return true
    }
    return false
}
