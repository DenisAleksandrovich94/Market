
import UIKit
import RealmSwift

//class Human: Object {
//    
//    @objc dynamic var name = ""
//    @objc dynamic var username = ""
//    @objc dynamic var password = ""
//    @objc dynamic var image = Data()
//    @objc dynamic var cardExpire = ""
//    @objc dynamic var cardNumber = ""
//    @objc dynamic var money = Double()
//   // @Persisted(primaryKey: true) var humanId: UUID
//    @objc dynamic var id = UUID()
//    var cart = List<Products>()
//    
//}


class Human: Object {
    
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var name: String
    @Persisted var password: String
    @Persisted var username: String
    @Persisted var image: Data
    @Persisted var cardExpire: String
    @Persisted var cardNumber: String
    @Persisted var money: Double
    @Persisted var cart: List<ProductsRealm>
    
}
