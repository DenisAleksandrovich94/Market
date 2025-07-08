import UIKit
import RealmSwift


//class Products: Object {
//    
//    
//    var human = LinkingObjects(fromType: Human.self, property: "cart")
//}
//


class ProductsRealm: Object {
    
    @Persisted(primaryKey: true) var idProduct = UUID()
    @Persisted var title = String()
    @Persisted var price = Double()
    @Persisted var thumbnail = String()
    @Persisted(originProperty: "cart") var human: LinkingObjects<Human>
  
}
