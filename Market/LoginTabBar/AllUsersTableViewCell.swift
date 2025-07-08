import UIKit



class AllUsersTableViewCell: UITableViewCell {
    
    @IBOutlet var imageUser: UIImageView!
    
    @IBOutlet var nameUser: UILabel!
    
    @IBOutlet private var chooseButton: UIButton!
    
    var completion: (() -> ())!
    
    
    func targetButton(completion: @escaping () -> ()) {
        chooseButton.addTarget(self, action: #selector(chooseUser), for: .touchUpInside)
        self.completion = completion
        
    }
    
    @objc private func chooseUser() {
        completion()
    }
    
}


//
//extension UITableViewCell {
//
//    func print(count:Int) -> Int {
//      let newCount = count + 1
//
//        return newCount
//        
//    }
//    
//  
//}
