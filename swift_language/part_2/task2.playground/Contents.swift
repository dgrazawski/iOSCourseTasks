import Cocoa

class Person{
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = 16
    }
    
    init?(age: Int){
        if age > 16 {
            self.name = "Default person"
            self.age = age
        } else {
            return nil
        }
    }
}




class Student: Person {
    let studentID: String
    var major: String
    
    required init(studentID: String, major: String, name: String, age: Int) {
        self.studentID = studentID
        self.major = major
        super.init(name: name, age: age)
    }
    
    convenience init(studentID: String, major: String, name: String) {
        let randomAge = Int.random(in: 16...24)
        self.init(studentID: studentID, major: major, name: name, age: randomAge)
    }
}

class Professor: Person {
    var faculty: String
    
    init(faculty: String, name: String, age: Int) {
        self.faculty = faculty
        super.init(name: name, age: age)
    }
}

struct University {
    let name: String
    let location: String
}


var obj1 = Person(age: 14)
var obj2 = Person(age: 16)
var obj3 = Person(name: "David", age: 32)

var person = Person(age: 15)
if let person = person {
    print("IS initialized")
} else {
    print("not initialized")
}

var stud1 = Student(studentID: "12", major: "CS", name: "Dawid")
var stud2 = Student(studentID: "13", major: "Math", name: "Maria", age: 24)

dump(stud1)

var prof1 = Professor(faculty: "Physics", name: "Adam", age: 58)

dump(prof1)

var uni1 = University(name: "UW", location: "Warsaw")

dump(uni1)
