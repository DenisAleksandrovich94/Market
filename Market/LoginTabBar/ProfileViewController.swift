import UIKit


class ProfileViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet var cardView: UIView!
    
    
    var user: Human! {
        didSet {
            print(user)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.layer.cornerRadius = 15
        cardView.layer.masksToBounds = true
        
    }
    
}
