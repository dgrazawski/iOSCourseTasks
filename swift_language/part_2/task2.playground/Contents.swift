import Cocoa

class Person{
    let name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = 16
    }
    
    init?(age: Int){
        if age >= 16 {
            self.name = "Default person"
            self.age = age
        } else {
            return nil
        }
    }
}




class Student: Person {
    let studentID: String
    let major: String
    
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
    let faculty: String
    
    init(faculty: String, name: String, age: Int) {
        self.faculty = faculty
        super.init(name: name, age: age)
    }
}

struct University {
    let name: String
    let location: String
}


let obj1 = Person(age: 14)
let obj2 = Person(age: 16)
let obj3 = Person(name: "David", age: 32)

let person = Person(age: 16)
if let person = person {
    print("IS initialized")
} else {
    print("not initialized")
}

let stud1 = Student(studentID: "12", major: "CS", name: "Dawid")
let stud2 = Student(studentID: "13", major: "Math", name: "Maria", age: 24)

dump(stud1)

let prof1 = Professor(faculty: "Physics", name: "Adam", age: 58)

dump(prof1)

let uni1 = University(name: "UW", location: "Warsaw")

dump(uni1)
