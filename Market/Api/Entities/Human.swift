
import UIKit
import RealmSwift

class Human: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var username = ""
    @objc dynamic var password = ""
    @objc dynamic var image = Data()
    @objc dynamic var cardExpire = ""
    @objc dynamic var cardNumber = ""
    @objc dynamic var money = Double()
    @objc dynamic var id = UUID()
    var cart = List<Products>()
    
}
