import UIKit
import RealmSwift


//class Products: Object {
//    
//    
//    var human = LinkingObjects(fromType: Human.self, property: "cart")
//}
//


class Products: Object {

    @Persisted(originProperty: "cart") var human: LinkingObjects<Human>
  
}
