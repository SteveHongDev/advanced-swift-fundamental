import UIKit

// MARK: - Single Responsibility Principle (SRP)

/*
 NOTES:
 A class should only be responsible for one thing
 */

struct Product {
    let price: Double
}

struct Invoice {
    var products: [Product]
    let id = NSUUID().uuidString
    var discountPercentage: Double = 0
    
    var total: Double {
        let total = products.map { $0.price }.reduce(0, { $0 + $1 })
        let discountedAmount = total * (discountPercentage / 100)
        return total - discountedAmount
    }
    
    func printInvoice() {
        let printer = InvoicePrinter(invoice: self)
        printer.printInvoice()
    }
    
    func saveInvoice() {
        // save invoice data locally or to database
        let persistence = InvoicePersistence(invoice: self)
        persistence.saveInvoice()
    }
}

struct InvoicePrinter {
    let invoice: Invoice
    
    func printInvoice() {
        print("-------------------")
        print("Invoice id: \(invoice.id)")
        print("Total cost $\(invoice.total)")
        print("Discounts: \(invoice.discountPercentage)")
        print("-------------------")
    }
}

struct InvoicePersistence {
    let invoice: Invoice
    
    func saveInvoice() {
        // save invoice data locally or to database
    }
}

let products: [Product] = [
    .init(price: 99.99),
    .init(price: 9.99),
    .init(price: 24.99)
]

let invoice = Invoice(products: products, discountPercentage: 20)
invoice.printInvoice()

let invoice2 = Invoice(products: products)
invoice2.printInvoice()


// MARK: - Open/Closed Principle (OCP)

/*
 Notes:
    Software entities (classes, modules, functions, etc.) should be open for extension, but closed for modification.
    In other words, we can add additional functionality (extension) without touching the existing code(modification) of an object.
 */

struct InvoicePersistenceOCP {
    let persistence: InvoicePersistable
    
    func save(invoice: Invoice) {
        persistence.save(invoice: invoice)
    }
}

protocol InvoicePersistable {
    func save(invoice: Invoice)
}

struct CoreDataPersistence: InvoicePersistable {
    func save(invoice: Invoice) {
        print("Save invoice to CoreData \(invoice.id)")
    }
}

struct FirestorePersistence: InvoicePersistable {
    func save(invoice: Invoice) {
        print("Save invoice to Firestore \(invoice.id)")
    }
}

let coreDataPersistence = CoreDataPersistence()
let databasePersistence = FirestorePersistence()
let persistenceOCP = InvoicePersistenceOCP(persistence: databasePersistence)

persistenceOCP.save(invoice: invoice)

// MARK: - Liskov Substitution Principle (LSP)

/*
 Notes:
    Derived or child classes/structures must be substitutable for their base or parent classes
 */

enum APIError: Error {
    case invalidUrl
    case invalidResponse
    case invalidStatusCode
}

struct MockUserService {
    func fetchUser() async throws {
        do {
            throw APIError.invalidResponse
        } catch {
            print("Error: \(error)")
        }
    }
}

let mockUserService = MockUserService()
Task { try await mockUserService.fetchUser() }

// MARK: - Interface Segregation Principle (ISP)

/*
 Notes:
    Do not force any client to implement an interface which is irrelevant to them
 */

protocol GestureProtocol {
    func didTap()
    func didDoubleTap()
    func didLongPress()
}

protocol SingleTapProtocol {
    func didTap()
}
protocol DoubleTapProtocol {
    func didDoubleTap()
}
protocol LongPressProtocol {
    func didLongPress()
}

struct SuperButton: SingleTapProtocol, DoubleTapProtocol, LongPressProtocol {
    func didTap() {
        
    }
    
    func didDoubleTap() {
        
    }
    
    func didLongPress() {
        
    }
}

struct DoubleTapButton: DoubleTapProtocol {
    func didDoubleTap() {
        print("DEBUG: Double tap...")
    }
}

// MARK: - Dependency Inversion Principle (DIP)

/*
 Notes:
    - High-level modules should not depend on low-level modules, but should depend on abstraction
    - If a high-level module imports any low-level module then the code becomes tightly coupled.
    - Changes in one class could break another class.
 */

protocol PaymentMethod {
    func execute(amount: Double)
}

struct DebitCardPayment: PaymentMethod {
    func execute(amount: Double) {
        print("Debit card payment success for \(amount)")
    }
}

struct StripePayment: PaymentMethod {
    func execute(amount: Double) {
        print("Stripe payment success for \(amount)")
    }
}

struct ApplePayPayment: PaymentMethod {
    func execute(amount: Double) {
        print("ApplePay payment success for \(amount)")
    }
}

struct Payment {
    var debitCardPayment: DebitCardPayment?
    var stripePayment: StripePayment?
    var applePayPayment: ApplePayPayment?
}

let paymentMethod = DebitCardPayment()
let payment = Payment(debitCardPayment: paymentMethod, stripePayment: nil, applePayPayment: nil)

payment.debitCardPayment?.execute(amount: 100)

struct PaymentDIP {
    let payment: PaymentMethod
    
    func makePayment(amount: Double) {
        payment.execute(amount: amount)
    }
}

let stripe = StripePayment()
let paymentDIP = PaymentDIP(payment: stripe)

paymentDIP.makePayment(amount: 200)


