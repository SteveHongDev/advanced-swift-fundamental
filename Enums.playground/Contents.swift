/*
 Enums
 
 Ary enumeration defines a common type for a group of related values and enables you to work with those values in a type-safe way within your code.
 
 Value based semantics.
 
 Whenever you have something that requires custom types, or options, an enumeration is the perfect structure to use
 */

import Foundation

// MARK: - Standard Enum

enum ColorScheme {
    case light
    case dark
    case custom
    case system
}

var scheme: ColorScheme = .light

scheme = .dark

if scheme == .dark {
    print("Black background color")
} else if scheme == .light {
    print("White background color")
} else {
    print("Custom background color")
}

// case가 추가되었을 때 error로 알려줌
switch scheme {
case .light:
    print("White background color")
case .dark:
    print("Black background color")
case .custom:
    print("Custom background color")
case .system:
    print("System background color")
}

// MARK: - Enum Raw Values

enum Weekday: String {
    case monday = "M"
    case tuesday = "T"
    case wednesday = "W"
    case thursday = "Th"
    case friday = "F"
    case saturday = "Sa"
    case sunday = "Su"
}

let today = Weekday.thursday
print("DEBUG: Today is \(today.rawValue)")

enum APIStatusCode: Int {
    case success = 200
    case unauthorized = 401
    case notFound = 404
    case serverError = 500
}

let statusCode: APIStatusCode = .serverError
print("Status code from api request is \(statusCode.rawValue)")

switch statusCode {
case .success:
    print("Do something with data")
case .unauthorized:
    print("API Request is unauthorized with status code \(statusCode.rawValue)")
case .notFound:
    print("Not found with status code \(statusCode.rawValue)")
case .serverError:
    print("Server error with status code \(statusCode.rawValue)")
}

// MARK: - Associated Values & Computed Properties

enum OrderStatus {
    case processed
    case shipped(trackingId: String, destination: String)
    case delivered
    
    var statusMessage: String {
        switch self {
        case .processed:
            return "Your order has been processed!"
        case .shipped(let trackingId, let destination):
            return "Your order has shipped! ( Destination: \(destination) ) Your tracking number is \(trackingId)"
        case .delivered:
            return "Your order has been delivered!"
        }
    }
}

var status: OrderStatus = .processed

print(status.statusMessage)

status = .shipped(trackingId: UUID().uuidString, destination: "Seoul")
print(status.statusMessage)

enum Color: CaseIterable {
    case red
    case green
    case blue
    case yellow
}

let allColors = Color.allCases

for color in allColors {
    print("Color is \(color)")
}
