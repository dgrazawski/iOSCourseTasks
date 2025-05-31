import Cocoa

struct School {
    var listOfPeople: [Person] = []
    
    subscript(role: SchoolRole) -> [Person] {
        return listOfPeople.filter {
            $0.role == role
        }
    }
    
    mutating func addPerson(_ person: Person) {
        listOfPeople.append(person)
    }
    
    enum SchoolRole{
        case student
        case teacher
        case administrator
    }
    
    class Person {
        let name: String
        let role: SchoolRole
        
        init(name: String, role: SchoolRole) {
            self.name = name
            self.role = role
        }
        
    }
}

func countStudents(for school: School) -> Int {
    return school[.student].count
}

func countTeachers(for school: School) -> Int {
    return school[.teacher].count
}

func countAdministrators(for school: School) -> Int {
    return school[.administrator].count
}



var school = School()

school.addPerson(School.Person(name: "John", role: .administrator))
school.addPerson(School.Person(name: "Adam", role: .administrator))
school.addPerson(School.Person(name: "Philip", role: .teacher))
school.addPerson(School.Person(name: "Stephanie", role: .teacher))
school.addPerson(School.Person(name: "Anna", role: .teacher))
//school.addPerson(School.Person(name: "Penelope", role: .student))
//school.addPerson(School.Person(name: "David", role: .student))

print(countAdministrators(for: school))
print(countTeachers(for: school))
print(countStudents(for: school))
