import Cocoa

class Person{
    let name: String
    var age: Int
    
    init(name: String) {
        self.name = name
        self.age = 16
    }
    
    init?(name: String, age: Int){
        if age > 16 {
            self.name = name
            self.age = age
        } else {
            return nil
        }
    }
}


var person = Person(name: "Tadeusz", age: 15)
if let person = person {
    print("IS")
} else {
    print("not is")
}

class Student: Person {
    let studentID: String
    var major: String
}
