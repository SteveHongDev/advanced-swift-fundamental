/*
 Memory Managment & Reference/Retain Cycles
 
 Memory management is crucial in iOS app development to ensure efficient utilization of the device's limited resources.
 Here are key reasons why it's important:
 
 1. Optimal Performance:
 Efficient memory management leads to better app performance.
 By releasing unnecessary memory promptly, apps can run smoothly without slowdowns or crashes.
 
 2. Resource Conservation:
 iOS devices have limited memory, and poorly managed memory can lead to resource exhaustion.
 Proper memory management helps conserve resources, preventing apps from hogging memory and affecting the overall system performance.
 
 3. Preventing Crashes:
 Memory leaks and excessive memory consumption can cause apps to crash.
 Effective memory management involves releasing unused memory and preventing memory leaks, reducing the likelihood of crashes.
 
 4. Battery Efficiency:
 Inefficient memory usage can impact battery life.
 By managing memory properly, apps can minimize unnecessary resource consumption, contributing to better battery efficiency.
 
 5. App Responsiveness:
 Swift and efficient memory management contribute to a more responsive user interface.
 Apps with optimal memory usage respond quickly to user interactions, providing a better user experience.
 
 In iOS development, we use Automatic Reference Counting (ARC) to manage memory automatically.
 However, understanding memory management principles remains crucial for identifying potential issues and optimizing performance.
 */

import UIKit

// MARK: - ARC
/*
 Swift uses Automatic Reference Counting (ARC) to track and manage your app's memory usage.
 In most cases, this means that memory management "just works" in Swift, 
 and you don't need to think about memory management yourself.
 
 ARC automatically frees up the memory used by class instances when those instances are no longer needed.
 
 Reference counting applies only to instances of classes.
 Structures and enumerations are value types, not reference types, and aren't stored and passed by reference.
 */

class Person {
    let name: String
    weak var apartment: Apartment?
    
    init(name: String) {
        self.name = name
        print("\(name) is being initialized.")
    }
    
    deinit { print("\(name) is being deinitialized.") }
}

var person1: Person?
var person2: Person?
var person3: Person?

//person1 = Person(name: "Steve Hong")
//person2 = person1
//person3 = person1

person1 = nil
person2 = nil
person3 = nil /* ARC doesn't deallocate person instance until ALL objects are deinitialized */

/*
 Also referred to as retain cycles
 Instance of a class never gets to a point where it has zero strong references, causing memory leaks
 This can happen if two class instances hold a strong reference to each other, such that each instance keeps the other alive.
 It's like two people holding hands that can never let go of one another, even if they tried.
 */

class Apartment {
    let unit: String
    var tenant: Person?
    var tenantId: String?
    
    init(unit: String) {
        self.unit = unit
        
        print("Did init apartment \(unit)")
    }
    
    deinit { print("Apartment \(unit) is being deinitialized") }
}

var john: Person?
var unit4A: Apartment?

john = Person(name: "John Doe")
unit4A = Apartment(unit: "4A")

john?.apartment = unit4A
unit4A?.tenant = john

john = nil
unit4A = nil

// MARK: - Weak Self

struct User {
    let username: String
}

class UserService {
    func fetchUser(completion: @escaping (User) -> Void) {
        print("Fetching User...")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            print("Entered completion handler")
            let user = User(username: "Steve Hong")
            completion(user)
        }
        
        print("Reached end of function")
    }
    
    deinit {
        print("DEBUG: Deinit user service")
    }
}

class UserManager {
    let service = UserService()
    var currentUser: User?
    
    func fetchUser() {
        service.fetchUser { [weak self] user in
            guard let self else {
                print("Self does not exist")
                return
            }
            
            print("Did receive user in manager \(user.username)")
            self.currentUser = user
            print("Current user on manager is \(self.currentUser?.username)")
        }
    }
    
    deinit {
        print("DEBUG: Deinit user manager")
    }
}

var userManager: UserManager? = UserManager()
userManager?.fetchUser()

userManager = nil
