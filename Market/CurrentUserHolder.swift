import UIKit

class CurrentUserHolder {
    
    static let shared = CurrentUserHolder()
    
    private init () { }
    
    var user = Human() {
        didSet{
            print(user)
            UserDefaults.standard.set("\(user.id)", forKey: "User")
        }
    }
}
