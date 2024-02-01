/*
 Protocols
 
 A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of 
 functuality.
 
 The protocol can then be adopted by a class, structure, or enumeration to provide an actual implementation of 
 those requirements. Any type that satisfies the requirements of a protocol is said to conform to that protocol.
 
 Protocols are abstract types
 Structs, classes and enums are concrete types
 
 Real Life Examples:
  - Security protocols (airports, banks, government facilities)
  - Safety protocol (hospitals)
  - Evacuation protbcols in emergency situations
  - Instructions to follow to complete a task (factories, mechanics)
 */

import Foundation

// MARK: - Syntax

protocol SomeProtocol {
    // stuff goes here
}

// MARK: - Example

protocol Identifiable {
    var id: String { get }
}

struct User: Identifiable {
    var id: String
    let name: String
    let age: Int
    let accountType: AccountType
}

let user1 = User(id: NSUUID().uuidString, name: "Steve Hong", age: 27, accountType: .pro)
let user2 = User(id: NSUUID().uuidString, name: "John Doe", age: 30, accountType: .basic)

print(user1.accountType.description)
print(user2.accountType.description)

struct Product: Identifiable {
    var id: String
    let price: Double
    let name: String
}

// MARK: - Shapes Example

protocol Shape {
    var numberOfSides: Int { get }
    var name: String { get }
    func getArea() -> Int
}

struct Rectangle: Shape {
    let numberOfSides: Int
    let name: String
    let width: Int
    let height: Int
    
    func getArea() -> Int {
        return width * height
    }
}

struct Square: Shape {
    let numberOfSides: Int
    let name: String
    let sideLength: Int
    
    func getArea() -> Int {
        return sideLength * sideLength
    }
}

let rectangle = Rectangle(numberOfSides: 4, name: "Rectangle", width: 5, height: 10)
let square = Square(numberOfSides: 4, name: "Square", sideLength: 8)

var shapes = [Shape]()

shapes.append(rectangle)
shapes.append(square)

for shape in shapes {
    if let shape = shape as? Rectangle {
        print("Shape width: \(shape.width)")
        print("Shape height: \(shape.height)")
    } else {
        print("Shape is not a rectangle")
    }
    print("Shape is \(shape.name) and shape area is \(shape.getArea())")
}


protocol FeedItemProtocol {
    var caption: String { get }
    
}

struct Post: FeedItemProtocol {
    var caption: String
}

struct Reel: FeedItemProtocol {
    var caption: String
}

// MARK: - Enum Example

protocol Describable {
    var description: String { get }
}

enum AccountType: Describable {
    case basic
    case pro
    case proPlus
    
    var description: String {
        switch self {
        case .basic:
            return "Basic account"
        case .pro:
            return "Pro account"
        case .proPlus:
            return "Pro Plus account"
        }
    }
}
