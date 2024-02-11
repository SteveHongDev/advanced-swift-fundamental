/*
 Module 16 - Higher Order Functions
 
 Swift provides several higher-order functions that operate on collections (arrays, dictionaries, sets, etc.)
 These function help us write cleaner and more concise code
 */

import UIKit

// MARK: - Map

var numbers = [1, 2, 3, 4, 5]
var squaredNumbers = [Int]()

// creates a new array
for number in numbers {
    squaredNumbers.append(number * number)
}
print(squaredNumbers)

// modifies original array
//for i in 0 ..< numbers.count {
//    numbers[i] = numbers[i] * numbers[i]
//}

let squaredUsingMap = numbers.map { num in
    return num * num
}
print(squaredUsingMap)

let squaredShortHand = numbers.map { $0 * $0 }
print(squaredShortHand)

struct User {
    let username: String
    let age: Int
}

let users: [User] = [
    .init(username: "Steve", age: 27),
    .init(username: "Smith", age: 40),
    .init(username: "Kelly", age: 15),
    .init(username: "John", age: 9)
]

let usernames = users.map { $0.username }
print(usernames)

// MARK: - Filter
// The filter function returns an array containing the elements of a collection that satisfy a given condition.

//let usersOlderThan30 = users.filter { user in
//    return user.age > 30
//}

let usersOlderThan30 = users.filter { $0.age > 30 }
print(usersOlderThan30)

let evenNumbers = numbers.filter { $0 % 2 == 0 }
print(evenNumbers)

// MARK: - Reduce
// The reduce function combines all elements of a collection into a single value using a specified closure.

var forLoopSum = 1

for num in numbers {
    forLoopSum *= num
}

let sum = numbers.reduce(0, { $0 + $1 })
print(sum)

let product = numbers.reduce(1, { $0 * $1 })
print(product)

// MARK: - ForEach

numbers.forEach { num in
    print(num)
}

numbers.forEach { print($0) }

// MARK: - FlatMap
// The flatmap function applies a transformation to each element of a collection and flattens the result.

let arrayOfArrays = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]

var flattenedForLoop = [Int]()
for array in arrayOfArrays {
    for num in array {
        flattenedForLoop.append(num)
    }
}

let flattenedArray = arrayOfArrays.flatMap { $0 }
print(flattenedArray)

// MARK: - CompactMap
// The compactMap function applies a transformation to each element of a collection and returns an array of non-nil results.

var names: [String?] = ["john", "kelly", nil, "steve", "ted", "mark", nil]

var compactNamesForLoop = [String]()

for name in names {
    if let name {
        compactNamesForLoop.append(name)
    }
}
print(compactNamesForLoop)

let compactMapNames = names.compactMap { $0 }
print(compactMapNames)

// MARK: - Sorting

let usersAgeDescending = users.sorted(by: { $0.age > $1.age })
print(usersAgeDescending.map { $0.username })
