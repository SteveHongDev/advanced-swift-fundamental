/*
 Generics
 
 Generic code enables you to write flexible, reusable functions and types that can work with any type.
 Similar to extensions, you can write code that avoids duplication and expresses its intent in a clear, abstracted manner.
 
 Generics are one of the most powerful features of Swift, and much of the Swift standard library is built with generic code.
 For example, Swift's Array type is a generic collection.
 
 You can create an array that holds Int values, or an array that holds String values, or custom Structs/Classes.
 */

import UIKit

// MARK: - Generic Structures

struct IntStack {
    var items = [Int]()
    
    mutating func push(_ item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

struct StringStack {
    var items = [String]()
    
    mutating func push(_ item: String) {
        items.append(item)
    }
    
    mutating func pop() -> String {
        return items.removeLast()
    }
}

struct Stack<T> {
    var items = [T]()
    
    mutating func push(_ item: T) {
        items.append(item)
    }
    
    mutating func pop() -> T {
        return items.removeLast()
    }
}

var intStack = Stack<Int>()
intStack.push(1)
intStack.push(2)
intStack.push(3)

print(intStack)

intStack.pop()

print(intStack)

var stringStack = Stack<String>()
stringStack.push("one")
stringStack.push("two")
stringStack.push("three")

print(stringStack)

stringStack.pop()

print(stringStack)


// MARK: - Generic Functions

protocol HTTPDataDownloader {
    func getData<T: Decodable>(as: T.Type, _ endpoint: String) -> T?
}

extension HTTPDataDownloader {
    func getData<T: Decodable>(as: T.Type, _ endpoint: String) -> T? {
        // build url
        guard let url = URL(string: endpoint) else { return nil }
        
        // request data
        let data = Data()
        
        // handle response and error
        let response = HTTPURLResponse()
        
        // parse data*
        let result = try? JSONDecoder().decode(T.self, from: data)
        
        // return data
        return result
    }
}

struct FeedItem: Decodable {
    let caption: String
}

struct User: Decodable {
    let id: String
    let username: String
}

struct FeedService: HTTPDataDownloader {
    func getFeedPosts() {
        let posts = getData(as: [FeedItem].self, "/user/feed")
    }
}

struct ProfileService: HTTPDataDownloader {
    func getUserProfile() {
        let users = getData(as: [User].self, "user/profile")
    }
}

let feedService = FeedService()
feedService.getFeedPosts()

let profileService = ProfileService()
profileService.getUserProfile()


// MARK: - Associated Types

/*
 When defining a protocol, it's sometimes useful to declare one or more associated types as part of the protocol's definition.
 An associated type givesya placeholder name to a type that's used as part of the protocol.
 The actual type to use for that associated type isn't specified until the protocol is adopted.
 Associated types are specified with the associatedtype keyword.
 */

protocol Cacheable {
    associatedtype Key
    associatedtype Value
    
    mutating func setValue(_ value: Value, forKey key: Key)
    
    func getValue(forKey key: Key) -> Value?
}

struct MemoryCache<Key: Hashable, Value>: Cacheable {
    var cache = [Key: Value]()
    
    mutating func setValue(_ value: Value, forKey key: Key) {
        cache[key] = value
    }
    
    func getValue(forKey key: Key) -> Value? {
        return cache[key]
    }
}

struct UserCache: Cacheable {
    typealias Key = String
    typealias Value = User
    
    var cache = [Key: Value]()
    
    mutating func setValue(_ value: Value, forKey key: Key) {
        cache[key] = value
    }
    
    func getValue(forKey key: Key) -> Value? {
        return cache[key]
    }
}

let currentUser = User(id: "stevehong", username: "Steve")
//var userCache = UserCache()
var userCache = MemoryCache<String, User>()

userCache.setValue(currentUser, forKey: "1234")

func fetchUser(_ uid: String) {
    if let user = userCache.getValue(forKey: uid) {
        print("User is \(user)")
    } else {
        print("Fetch user from API")
    }
}

fetchUser("1234")

var postCache = MemoryCache<String, FeedItem>()
