import Cocoa

protocol Borrowable {
    var borrowDate: Date? { get set }
    var returnDate: Date? { get set }
    var isBorrowed: Bool { get set }
    mutating func checkIn()
}

extension Borrowable {
    mutating func checkIn() {
        if isBorrowed {
            borrowDate = nil
            returnDate = nil
            isBorrowed = false
        }
    }
    
    func isOverdue() -> Bool {
        guard let returnDate = returnDate else {
            return false
        }
        return returnDate > Date()
    }
}

class Item {
    let id: String
    let title: String
    let author: String
    
    init(title: String, author: String) {
        self.id = UUID().uuidString
        self.title = title
        self.author = author
    }
}

class Book: Item, Borrowable {
    var borrowDate: Date?
    var returnDate: Date?
    var isBorrowed: Bool
    
    override init(title: String, author: String) {
        isBorrowed = false
        super.init(title: title, author: author)
    }
    
    init(title: String, author: String, isBorrowed: Bool, borrowDate: Date, returnDate: Date) {
        self.isBorrowed = isBorrowed
        self.borrowDate = borrowDate
        self.returnDate = returnDate
        super.init(title: title, author: author)
    }
}

enum LibraryError: Error {
    case itemNotFound
    case itemNotBorrowable
    case alreadyBorrowed
}


class Library {
    var items: [String: Item]
    
    init() {
        self.items = [:]
    }
    
    init(items: [String : Item]) {
        self.items = items
    }
    
    func addBook(_ book: Book) {
        self.items[book.id] = book
    }
    
    func borrowItem(by id: String) throws -> Item {
        guard var borrowed = self.items[id] else {
            throw LibraryError.itemNotFound
        }
//        guard var borrowed = borrowed as? Borrowable else {
//            throw LibraryError.itemNotBorrowable
//        }
//        if borrowed.isBorrowed {
//            throw LibraryError.alreadyBorrowed
//        }
//        
//        borrowed.borrowDate = Date()
//        borrowed.returnDate = Calendar.current.date(byAdding: .day, value: 7, to: borrowed.borrowDate ?? Date())
//        borrowed.isBorrowed = true
//        
//        self.items.updateValue(borrowed as! Item, forKey: id)
//        
//        return borrowed as! Item
        if borrowed is Borrowable {
            borrowed.is
        }
    }
}
