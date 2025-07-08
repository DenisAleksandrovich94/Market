import UIKit
import RealmSwift

class StoreTableViewCell: UITableViewCell {
    
    
    @IBOutlet private var imageCell: UIImageView!
    
    @IBOutlet private var addToTheBasket: UIButton!
    
    @IBOutlet private var buyAProduct: UIButton!
    
    @IBOutlet private var titleProduct: UILabel!
    
    @IBOutlet private var priceProduct: UILabel!
    
    var product: ProductsRealm!
    
    var error: (() -> ())!
    
    func addButtonsTarget(product: ProductsRealm, error: @escaping () -> ()) {
        addToTheBasket.addTarget(self, action: #selector(putInABasket), for: .touchUpInside)
        buyAProduct.addTarget(self, action: #selector(buysTheProduct), for: .touchUpInside)
        self.error = error
        self.product = product
        titleProduct.text = product.title
        priceProduct.text = "\(product.price)"
        
        if let url = URL(string: product.thumbnail) {
            
            DispatchQueue.global().async {
                let imageData = try? Data(contentsOf: url)
                
                if let data = imageData, let image = UIImage(data: data) {
                    DispatchQueue.main.async {[weak self] in
                        self?.imageCell.image = image
                    }
                }
            }
        }
        
    }
    
    
    @objc private func putInABasket() {
        print("basket")
    }
    
    @objc private func buysTheProduct() {
        let realm = try! Realm()
        if CurrentUserHolder.shared.user.money >= product.price {
            if let product = realm.object(ofType: ProductsRealm.self, forPrimaryKey: product.idProduct)
               {
                
                try! realm.write {
                    CurrentUserHolder.shared.user.money -= product.price
                   // user.money -= product.price
                    realm.delete(product)
                }
                //CurrentUserHolder.shared.user = user
                NotificationCenter.default.post(name: Notification.Name("reloadTableView"), object: nil)
                
            }
    
        } else {
            error()
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: .init(top: 10, left: 8, bottom: 0, right: 8))
        
        imageCell.layer.cornerRadius = 10
        imageCell.clipsToBounds = true
        // imageCell.layer.masksToBounds = true
        
    }
    
}
