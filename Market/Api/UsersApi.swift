import UIKit


struct User: Codable {
    
    let firstName: String
    let lastName: String
    let bank: Bank
    let username: String
    let password: String
    let image: String
    
    struct Bank: Codable {
        let cardExpire: String
        let cardNumber: String
    }
}
