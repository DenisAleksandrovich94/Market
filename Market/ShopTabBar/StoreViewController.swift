import UIKit
import RealmSwift


class StoreViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableViewShop: UITableView!
    
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var settingsUserImage: UIButton!
    @IBOutlet var nameLabel: UILabel!
    
    
    @IBOutlet var infoImage: UIImageView!
    @IBOutlet var theLastOperationLabel: UILabel!
    @IBOutlet var moneyLabel: UILabel!
    
    var products = [ProductsRealm]()
    
    func setUser() {
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.layer.masksToBounds = true
        infoImage.layer.cornerRadius = 10
        infoImage.layer.masksToBounds = true
        
        if let userString = UserDefaults.standard.string(forKey: "User"), let id =  UUID(uuidString: userString) {
            let realm = try! Realm()
            if let user = realm.object(ofType: Human.self, forPrimaryKey: id) {
                
                settingsUserImage.addTarget(self, action: #selector(changeImage), for: .touchUpInside)
                CurrentUserHolder.shared.user = user
                nameLabel.text = user.name
                moneyLabel.text = "\(user.money)"
                
                if !(user.image.isEmpty){
                    userImage.image = UIImage(data: user.image)
                    
                } else {
                    userImage.image = UIImage(named: "user")
                }
            }
        }
        
    }
    
    @objc func changeImage() {
        print("Сменить фото")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreTableViewCell", for: indexPath) as! StoreTableViewCell
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.masksToBounds = true
        cell.addButtonsTarget(product: products[indexPath.row]) {
            let alert = UIAlertController(title: "No money", message: "Add balance", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            self.present(alert, animated: true)
            
        }
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewShop.dataSource = self
        addNavigationItem()
        downloadRealmProducts()
        setUser()
        NotificationCenter.default.addObserver(forName: Notification.Name("reloadTableView"), object: nil, queue: .main) { [weak self] notification in
            guard let self else { return }
            downloadRealmProducts()
            setUser()
            tableViewShop.reloadData()
            
        }
    }
    
    
    private func addNavigationItem() {
        
        let addOneProduct = UIAction(title: "One product", image: UIImage(systemName: "arrow.trianglehead.clockwise")) {[weak self] action in
            
            self?.fetchProducts(number: 1)
        }
        
        let addTenProduct = UIAction(title: "Ten product", image: UIImage(systemName: "10.arrow.trianglehead.clockwise")) {[weak self] action in
            
            self?.fetchProducts(number: 10)
        }
        
        let enterTheQuantity = UIAction(title: "Enter the quantity", image: UIImage(systemName: "plus.arrow.trianglehead.clockwise")) {[weak self] action in
            guard let self else { return }
            
            let alert = UIAlertController(title: "Enter the number of products", message: "Max quantity 121", preferredStyle: .alert)
            
            alert.addTextField()
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] action in
                
                
                if let text = alert.textFields![0].text, let number = Int(text) {
                    
                    if number > 0, number <= 121 {
                        
                        self?.fetchProducts(number: number)
                    }
                }
            }))
            present(alert, animated: true)
        }
        
        let menu = UIMenu(title: "Order goods to the store", children: [addOneProduct, addTenProduct, enterTheQuantity])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "truck.box"), menu: menu)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(openVCLogin))
        navigationItem.rightBarButtonItem?.tintColor = .systemYellow
        navigationItem.leftBarButtonItem?.tintColor = .systemYellow
        
    }
    
    func fetchProducts(number: Int) {
        NetworkMarketApi.shared.fetchCarts(products: number) {[weak self] result in
            
            switch result {
            case.success(let products):
                self?.saveingProducts(products: products)
                
                DispatchQueue.main.async {[weak self] in
                    self?.downloadRealmProducts()
                    self?.tableViewShop.reloadData()
                }
                print(products.count)
            case.failure(let error):
                print(error)
                print("1")
            }
        }
        
    }
    
    @objc private func openVCLogin() {
        dismiss(animated: true)
    }
    
    func downloadRealmProducts() {
        
        let realm = try! Realm()
        products = Array(realm.objects(ProductsRealm.self))
        
        
    }
    
    private func saveingProducts(products: [ProductsApi.Products]) {
        let realm = try! Realm()
        
        
        let newProducts = products.map { product in
            let entities = ProductsRealm()
            entities.title = product.title
            entities.price = product.price
            entities.thumbnail = product.thumbnail
            return entities
        }
        
        try! realm.write {
            
            realm.add(newProducts)
            
        }
        
        //print(realm.objects(ProductsRealm.self))
    }
    
}
