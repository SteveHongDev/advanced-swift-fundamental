/*
 Module 13 - Classes
 
 Classes in Swift:
 
 1. A class is a reference type in Swift, which means when you create an instance of a class and assign it to
 another variable or pass it to a function, you're working with a reference to the same object,
 not a copy of the object itself.
 
 2. Classes are used for defining more complex data structures and are the foundation for object-oriented programming in Swift.
 Here are some key features and characteristics of classes:
 
    - Reference Types: When you create an instance of a class and assign it to multiple variables or pass it as a parameter, 
    all of these variables will reference the same object in memory.
 
    - Inheritance: Classes support inheritance, allowing you to create new classes based on existing classes (superclasses and subclasses).
    
    - Mutability: You can change the properties and methods of a class instance even if it's declared as a constant (with let).
 
 ------------------------
 
 When to Choose:
 
 Use Classes when:
    - You need inheritance to create a hierarchy of related types.
    - You want to share code and behavior among multiple classes using a common superclass.
    - You need reference semantics, where changes to one instance affect all references to that instance.
 
 Use Structs with Protocols when:
    - You prefer value semantics, and instances should be copied when passed around.
    - You want to share behavior among different types that don't have a hierarchical relationship.
    - You are working with simple data structures or immutable models.
 
 In Swift, the choice between classes and structs with protocols often depends on the specific requirements of your application,
 the desired semantics, and the relationships between your types. Both approaches have their strengths, and Swift's flexibility
 allows you to choose the one that best fits your needs.
 
 */

import UIKit

// MARK: - Class Init
// classes require initializers, unlike structs, where init is implicity handled

class User {
    var username: String
    var age: Int
    
    init(username: String, age: Int) {
        self.username = username
        self.age = age
    }
}

let user = User(username: "Steve", age: 27)
print(user.username)
print(user.age)

var userCopy = user
userCopy.username = "John Doe"

var userCopy2 = userCopy
userCopy2.username = "Jane Smith"

user.age = 40

/* Modifying copy of class modifies all copies and original object */

print("User copy username is \(userCopy.username)")
print("User copy 2 username is \(userCopy.username)")
print("Original user username is \(user.username)")

print("User copy age is \(userCopy.age)")
print("User copy 2 age is \(userCopy.age)")
print("Original user age is \(user.age)")

// MARK: - Inheritance

// superclass
class Employee {
    let firstName: String
    let lastName: String
    let id: String = NSUUID().uuidString
    
    var fullName: String {
        return firstName + " " + lastName
    }
    
    var email: String {
        return "\(firstName.lowercased()).\(lastName.lowercased())@domain.com"
    }
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
        
//        self.fullName = firstName + " " + lastName
    }
}

// subclass
class FullTimeEmployee: Employee {
    var salary: Double
    
//    override var email: String {
//        let originalEmail = super.email
//        return originalEmail.replacingOccurrences(of: "domain", with: "fulltime_domain")
//    }
    
    init(firstName: String, lastName: String, salary: Double) {
        self.salary = salary
        super.init(firstName: firstName, lastName: lastName)
    }
    
    func updateSalary(_ salary: Double) {
        self.salary = salary
    }
}

// subclass
class ContractEmployee: Employee {
    var hourlyRate: Double
    
    override var email: String {
        let originalEmail = super.email
        return originalEmail.replacingOccurrences(of: "domain", with: "contract_domain")
    }
    
    init(firstName: String, lastName: String, hourlyRate: Double) {
        self.hourlyRate = hourlyRate
        super.init(firstName: firstName, lastName: lastName)
    }
}

var allEmployees = [Employee]()

let fulltime1 = FullTimeEmployee(firstName: "John", lastName: "Doe", salary: 50_000)
let fulltime2 = FullTimeEmployee(firstName: "Jane", lastName: "Smith", salary: 60_000)

fulltime1.updateSalary(85_000)
print(fulltime1.salary)

let contract1 = ContractEmployee(firstName: "Kelly", lastName: "Kim", hourlyRate: 100)
let contract2 = ContractEmployee(firstName: "Steve", lastName: "Hong", hourlyRate: 110)

allEmployees = [fulltime1, fulltime2, contract1, contract2]

for employee in allEmployees {
    print(employee.email)
}
