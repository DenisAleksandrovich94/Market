import UIKit
import RealmSwift


class UserBasketViewController: UIViewController, UITableViewDataSource {
  
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet private var userImage: UIImageView!
    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var balanceLabel: UILabel!
    
    @IBOutlet private var totalBacketLabel: UILabel!
    @IBOutlet private var buyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        buyButton.addTarget(self, action: #selector(buyProducts), for: .touchUpInside)

    }
    
    @objc private func buyProducts() {
        
        let buyAllProducts = UIAlertAction(title: "Buy all products", style: .default) { action in
            print("buy All Products")
        }
        
        let buySelectedProduct = UIAlertAction(title: "Buy selected product", style: .default) { action in
            print("buy Selected Product")
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let alert = UIAlertController(title: "What do you want to buy?", message: nil, preferredStyle: .actionSheet)
 
        alert.addAction(buyAllProducts)
        alert.addAction(buySelectedProduct)
        alert.addAction(cancel)
        present(alert, animated: true)
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserBasketTableViewCell") as! UserBasketTableViewCell
        cell.addButton()
        return cell
    }
    
    
    
    
}
