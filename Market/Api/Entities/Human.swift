
import UIKit
import RealmSwift

class Human: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var username = ""
    @objc dynamic var password = ""
    @objc dynamic var image = ""
    @objc dynamic var cardExpire = ""
    @objc dynamic var cardNumber = ""
    var cart = List<Products>()
    
    
}
