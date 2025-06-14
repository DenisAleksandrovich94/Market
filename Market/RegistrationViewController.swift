

import UIKit
import RealmSwift


class RegistrationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        installRightBarButton()
    }
    
    
    func installRightBarButton() {
        
        let menu = UIMenu()
        UIMenu(title: <#T##String#>, children: <#T##[UIMenuElement]#>)
        
        
        
        
        navigationItem.rightBarButtonItem?.menu = menu
        
        
       // navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New user", style: .plain, target: self, action: #selector(selectRegistration))
    }
    
//    @objc func selectRegistration() {
//        print("select")
//    }
    
}
