import UIKit
import RealmSwift

class ProfileViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet var cardView: UIView!
    
    @IBOutlet var photoUser: UIImageView!
    
    @IBOutlet var balanceLabel: UILabel!
    
    @IBOutlet var cardNumberLabel: UILabel!
    
    @IBOutlet var cardExpireLabel: UILabel!
    
    @IBOutlet var userName: UILabel!
    
    @IBOutlet var addMoneyButton: UIButton!
    
    @IBOutlet var getMoneyButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.layer.cornerRadius = 15
        cardView.layer.masksToBounds = true
        fillOutTheUserCard()
        addMoneyButton.addTarget(self, action: #selector(addMoney), for: .touchUpInside)
        getMoneyButton.addTarget(self, action: #selector(getMoney), for: .touchUpInside)
    }
    
    
    
    @objc func addMoney() {
        addAlert(sign: .plus)
       
        
    }
    
    @objc func getMoney() {
        addAlert(sign: .minus)
    }
    
    func addAlert(sign: Sign) {
        
        let alert = UIAlertController(title: "", message: "сумма", preferredStyle: .alert)
        
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {[weak self] action in
            guard let self else { return }
            if let text = alert.textFields![0].text, let number = Double(text) {
                fetchRealm(number: number, sign: sign)
                
            }
            
        }))
        present(alert, animated: true)
   
    }
    
    func fetchRealm(number: Double ,sign: Sign) {
        let realm = try! Realm()
        
        if let currentUser = realm.object(ofType: Human.self, forPrimaryKey: CurrentUserHolder.shared.user.id) {
            
            try! realm.write {
                
                if sign == .plus {
                    currentUser.money += number
                } else {
                    currentUser.money -= number
                }
                balanceLabel.text = "\(currentUser.money)"
            }
            
        }
    }
    
    enum Sign {
        case plus
        case minus
    }
    
    func fillOutTheUserCard () {
        
        balanceLabel.text =  "\(CurrentUserHolder.shared.user.money)"
        cardNumberLabel.text = CurrentUserHolder.shared.user.cardNumber
        cardExpireLabel.text = CurrentUserHolder.shared.user.cardExpire
        userName.text = CurrentUserHolder.shared.user.name
        photoUser.layer.cornerRadius = /*photoUser.frame.width/2*/ 30
        photoUser.layer.masksToBounds = true
        
        if !CurrentUserHolder.shared.user.image.isEmpty {
            photoUser.image = UIImage(data: CurrentUserHolder.shared.user.image)
        } else {
            photoUser.image = UIImage(named: "user")
            
        }
        
        
    }
    
}
