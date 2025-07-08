import UIKit

struct ProductsApi: Codable {
    
    var carts: [Carts]
    
    
    struct Carts: Codable {
        var products: [Products]
    }
    
    struct Products: Codable {
        var title: String
        var price: Double
        var thumbnail: String
    }
    
}



