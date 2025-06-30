import UIKit
import RealmSwift


class StoreViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableViewShop: UITableView!
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreTableViewCell", for: indexPath) as! StoreTableViewCell
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.masksToBounds = true
        cell.addButtonsTarget(index: indexPath.row)
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewShop.dataSource = self
        addNavigationItem()
        
    }
    
    
    func addNavigationItem() {
        
        let addOneProduct = UIAction(title: "One product", image: UIImage(systemName: "arrow.trianglehead.clockwise")) { action in
            
            NetworkMarketApi.shared.fetchCarts(products: 1) { result in
                switch result {
                case.success(let products):
                    print(products)
                case.failure(let error):
                    print(error)
                }
            }
            
        }
        
        let addTenProduct = UIAction(title: "Ten product", image: UIImage(systemName: "10.arrow.trianglehead.clockwise")) { action in
            
            NetworkMarketApi.shared.fetchCarts(products: 10) { result in
                switch result {
                case.success(let products):
                    print(products)
                case.failure(let error):
                    print(error)
                }
            }
        }
        
        let enterTheQuantity = UIAction(title: "Enter the quantity", image: UIImage(systemName: "plus.arrow.trianglehead.clockwise")) {[weak self] action in
            guard let self else { return }
           
            let alert = UIAlertController(title: nil, message: "Enter the number of products", preferredStyle: .alert)
            
            alert.addTextField()
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                
            })
            )
            
            
            present(alert, animated: true)
            
            NetworkMarketApi.shared.fetchCarts(products: 1) { result in
                switch result {
                case.success(let products):
                    print(products)
                case.failure(let error):
                    print(error)
                }
            }
        }
        
        let menu = UIMenu(title: "Order goods to the store", children: [addOneProduct, addTenProduct, enterTheQuantity])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "truck.box"), menu: menu)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(openVCLogin))
        navigationItem.rightBarButtonItem?.tintColor = .systemYellow
        navigationItem.leftBarButtonItem?.tintColor = .systemYellow

    }
    
    @objc private func openVCLogin() {
        dismiss(animated: true)
    }
    
}
