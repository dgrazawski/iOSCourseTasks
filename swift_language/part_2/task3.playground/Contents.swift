import Cocoa

import Cocoa

class Person{
    var name: String
    var age: Int
    var isAdult: Bool {
        return age >= 18
    }
    static let minAgeForEnrollment = 16
    
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
