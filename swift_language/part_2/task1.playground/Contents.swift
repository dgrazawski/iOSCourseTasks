import Cocoa

struct User {
    let username: String
    let email: String
    var password: String
}

class UserManager {
    var users: [String: User]
    var userCount: Int {
        return users.count
    }
    
    init() {
        self.users = [:]
    }
    
    init(users: [String : User]) {
        self.users = users
    }
    
    func registerUser(username: String, email: String, password: String) -> Bool{
        if users[username] == nil {
            let newUser = User(username: username, email: email, password: String(password.hashValue))
            users[username] = newUser
            return true
        }
        
        return false
    }
    
    func login(username: String, password: String) -> Bool {
        if let user = users[username] {
            if String(user.password) == String(password.hashValue) {
                return true
            }
        }
        return false
    }
    
    func removeUser(username: String) -> Bool {
        if let user = users.removeValue(forKey: username) {
            return true
        }
        return false
    }
    
}

class AdminUser: UserManager {
    override init() {
        super.init()
    }
    override init(users: [String : User]) {
        super.init(users: users)
    }
    deinit {
        print("Admin removed from memory!!!")
    }
    func listAllUsers() -> [String] {
        var usersList = [String]()
        users.forEach { (key, value) in
            usersList.append(key)
        }
        return usersList
    }
}


var c1 = AdminUser()
print(c1.registerUser(username: "c1", email: "c2", password: "c3"))
print(c1.registerUser(username: "c1", email: "c2", password: "c3"))
print(c1.registerUser(username: "c1", email: "c2", password: "c3"))
print(c1.registerUser(username: "c3", email: "c2", password: "c3"))

for (key, user) in c1.users {
    print("\(key) -> \(user)")
}

print(c1.login(username: "c1", password: "c2"))
print(c1.login(username: "c1", password: "c3"))
print(c1.listAllUsers())
print(c1.removeUser(username: "c4"))
print(c1.removeUser(username: "c3"))
print(c1.listAllUsers())
print(c1.userCount)
var c2 = AdminUser(users: c1.users)
print(c2.listAllUsers())

c2 = AdminUser()
