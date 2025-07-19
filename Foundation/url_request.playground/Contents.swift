import UIKit

struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}

struct Geo: Codable {
    let lat: String
    let lng: String
}

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}

struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}


let url = URL(string: "https://jsonplaceholder.typicode.com/users")

func getEmails(url: URL?) {
    guard let url = url else { return }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("Error \(error) occured")
            return
        }
        if let response = response as? HTTPURLResponse {
            if response.statusCode != 200 {
                return
            }
        }
        guard let data = data else { return }
        do {
            let list = try JSONDecoder().decode([User].self, from: data)
            for person in list {
                print(person.email)
            }
        } catch {
            print("Failed")
        }
        
        
    }
    
    task.resume()
}

getEmails(url: url)
