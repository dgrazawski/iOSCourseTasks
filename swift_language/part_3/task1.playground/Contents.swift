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
        return returnDate < Date()
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
        guard var foundItem = self.items[id] else {
            throw LibraryError.itemNotFound
        }
        guard var borrowed = foundItem as? Borrowable else {
            throw LibraryError.itemNotBorrowable
        }
        if borrowed.isBorrowed {
            throw LibraryError.alreadyBorrowed
        }
        
        borrowed.borrowDate = Date()
        borrowed.returnDate = Calendar.current.date(byAdding: .day, value: 7, to: borrowed.borrowDate ?? Date())
        borrowed.isBorrowed = true
        
        
        return foundItem
    }
}



let library = Library()


let book = Book(title: "LOTR", author: "JRR Tolkien")
library.addBook(book)

print("Added book with ID: \(book.id)")
print("Title: \(book.title), Author: \(book.author)")
print("Borrowed?: \(book.isBorrowed ? "Yes" : "No")")


do {
    let borrowedItem = try library.borrowItem(by: book.id)
    print("Successfully borrowed: \(borrowedItem.title)")
    
    if var borrowedBook = borrowedItem as? Book {
        print("Borrow Date: \(borrowedBook.borrowDate!)")
        print("Return Date: \(borrowedBook.returnDate!)")
        print("Is Overdue?: \(borrowedBook.isOverdue() ? "Yes" : "No")")
        
        
        do {
            let failedBorrow = try library.borrowItem(by: book.id)
        } catch {
            print("Failed to borrow again (already borrowed): \(error)")
        }

        
        borrowedBook.returnDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        print("Simulated overdue by setting return date to yesterday.")
        print("New Return Date: \(borrowedBook.returnDate!)")
        print("Is Overdue Now?: \(borrowedBook.isOverdue() ? "Yes" : "No")")

        
        borrowedBook.checkIn()
        print("Book checked in.")
        print("Borrowed?: \(borrowedBook.isBorrowed ? "Yes" : "No")")
        print("Borrow Date: \(String(describing: borrowedBook.borrowDate))")
        print("Return Date: \(String(describing: borrowedBook.returnDate))")
    }
} catch {
    print("Failed to borrow: \(error)")
}


do {
    let nonExistentItem = try library.borrowItem(by: "non-existent-id")
} catch {
    print("Error borrowing non-existent item: \(error)")
}


class MusicRecord: Item {
    
}

let record = MusicRecord(title: "Some title", author: "Some Band")
library.items[record.id] = record

do {
    let nonBorrowableItem = try library.borrowItem(by: record.id)
} catch {
    print("Error borrowing non-borrowable item: \(error)")
}


do {
    let borrowedAgain = try library.borrowItem(by: book.id)
    print("Borrowed again after check-in: \(borrowedAgain.title)")
} catch {
    print("Unexpected error when re-borrowing: \(error)")
}
