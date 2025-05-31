import Cocoa

let books = [
["title": "Swift Fundamentals", "author": "John Doe", "year": 2015, "price": 40, "genre": ["Programming", "Education"]],
["title": "The Great Gatsby", "author": "F. Scott Fitzgerald", "year": 1925, "price": 15, "genre": ["Classic", "Drama"]],
["title": "Game of Thrones", "author": "George R. R. Martin", "year": 1996, "price": 30, "genre": ["Fantasy", "Epic"]],
["title": "Big Data, Big Dupe", "author": "Stephen Few", "year": 2018, "price": 25, "genre": ["Technology", "Non-Fiction"]],
["title": "To Kill a Mockingbird", "author": "Harper Lee", "year": 1960, "price": 20, "genre": ["Classic", "Drama"]]
]



var discountedPrices: [Double] = books.compactMap { book in
    if let book = book["price"] as? Double {
        return book * 0.9
    } else if let book = book["price"] as? Int {
        print(book)
        return Double(book) * 0.9
    } else {
        return nil
    }
}

dump(discountedPrices)

var booksPostedAfter2000: [String] = books.filter { book in
    if let postYear = book["year"] as? Int {
        return postYear > 2000
    } else {
        return false
    }
}
.compactMap { book in
    book["title"] as? String
}

dump(booksPostedAfter2000)


var allGenres: Set<String> = Set(
    books.flatMap { book in
        book["genre"] as? [String] ?? []
    }
)

dump(allGenres)


var totalCost = books.reduce(0, {$0 + ($1["price"] as? Int ?? 0)})

dump(totalCost)
