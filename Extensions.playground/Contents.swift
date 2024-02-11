/*
 
 Extensions
 
 In Swift, extensions allow you to add new functionality to existing types,
 including types defined by the Swift standard library, without modifying their original source code.
 
 Extensions can add computed properties, methods, and initializers.
 
 */

import UIKit

// MARK: - Int

var num = 4
var squaredNum = num * num

var num2 = 8
var squaredNum2 = num2 * num2

func square(_ num: Int) -> Int {
    return num * num
}

extension Int {
    var squared: Int {
        return self * self
    }
    
    func doubled() -> Int {
        return self * 2
    }
}

num.squared
num2.squared

num.doubled()


// MARK: - Date

extension Date {
    private var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm dd, yyyy"
        formatter.dateStyle = .full
        
        return formatter
    }
    
    func asString() -> String {
        return formatter.string(from: self)
    }
}

print(Date().asString())


// MARK: - Protocol Extensions

protocol HTTPDataDownloader {
    func getData(_ endpoint: String)
}

extension HTTPDataDownloader {
    func getData(_ endpoint: String) {
        // build url
        
        // request data
        
        // handle response and error
        
        // parse data*
        
        // return data
        
        print("Get data from \(endpoint) endpoint")
    }
}

struct FeedService: HTTPDataDownloader {
    func getFeedPosts() {
        getData("/user/feed")
    }
}

struct ProfileService: HTTPDataDownloader {
    func getUserProfile() {
        getData("/user/profile")
    }
}

let feedService = FeedService()
feedService.getFeedPosts()

let profileService = ProfileService()
profileService.getUserProfile()


// MARK: - Conditional Extensions

protocol Purchasable {
    var price: Double { get }
}

struct Product: Purchasable {
    let name: String
    let price: Double
}

struct Subscription: Purchasable {
    let name: String
    let price: Double
}

let product1 = Product(name: "MacBook Pro", price: 1299)
let product2 = Product(name: "AirPods Pro", price: 299)
let product3 = Product(name: "iPad Pro", price: 599)

let products = [product1, product2, product3]

let subscriptions = [
    Subscription(name: "Basic", price: 20),
    Subscription(name: "Diamond", price: 40)
]

func getProductSum(_ products: [Purchasable]) -> Double {
    var sum = 0.0
    
    for product in products {
        sum += product.price
    }
    
    return sum
}

extension Array where Element: Purchasable {
    func getTotal() -> Double {
        var sum = 0.0
        
        for element in self {
            sum += element.price
        }
        
        return sum
    }
}

let total = products.getTotal()
let subscriptionsTotal = subscriptions.getTotal()
