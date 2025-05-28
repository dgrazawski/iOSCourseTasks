import Cocoa

class Person{
    let name: String
    let age: Int
    var isAdult: Bool {
        return age >= 18
    }
    static let minAgeForEnrollment = 16
    lazy var profileDescription = "\(self.name) is \(self.age) years old."
    
    init(name: String, age: Int) {
        self.name = name
        self.age = Person.minAgeForEnrollment
    }
    
    init?(age: Int){
        if age >= Person.minAgeForEnrollment {
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
    var formattedID: String {
        return "ID: \(studentID)".uppercased()
    }
    weak var advisor: Professor?
    nonisolated(unsafe) static var studentCount: Int = 0
    
    required init(studentID: String, major: String, name: String, age: Int) {
        Student.studentCount += 1
        self.studentID = studentID
        self.major = major
        super.init(name: name, age: age)
    }
    
    convenience init(studentID: String, major: String, name: String) {
        let randomAge = Int.random(in: 16...24)
        self.init(studentID: studentID, major: major, name: name, age: randomAge)
    }
    
    deinit {
        Student.studentCount -= 1
    }
}

class Professor: Person {
    let faculty: String
    nonisolated(unsafe) static var professorCount = 0
    var fullTitle: String {
        return "Professor \(self.name) from \(faculty)."
    }
    
    init(faculty: String, name: String, age: Int) {
        Professor.professorCount += 1
        self.faculty = faculty
        super.init(name: name, age: age)
    }
    
    deinit {
        Professor.professorCount -= 1
    }
}

struct University {
    let name: String
    let location: String
    
    var description: String {
        return "University Name: \(self.name) located in: \(self.location)"
    }
}

print("Stud count: \(Student.studentCount)")
var stud1: Student? = Student(studentID: "1", major: "2", name: "3")
print("Stud count: \(Student.studentCount)")
stud1 = nil
print("Stud count: \(Student.studentCount)")
stud1 = Student(studentID: "2", major: "CS", name: "Maria", age: 24)
print(stud1?.formattedID ?? "")
print(stud1?.profileDescription ?? "")

print("Prof count: \(Professor.professorCount)")
let prof1 = Professor(faculty: "Math", name: "Adam", age: 58)
print("Prof count: \(Professor.professorCount)")
print(prof1.fullTitle)

let uni1 = University(name: "UW", location: "Warsaw")
print(uni1.description)
