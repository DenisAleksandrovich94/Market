import UIKit


class CurrentUserHolder {
    
    static let shared = CurrentUserHolder()
    
    private init () { }
    
    var user = Human()
    
}
