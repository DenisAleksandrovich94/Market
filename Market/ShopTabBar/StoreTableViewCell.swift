import UIKit
import RealmSwift

class StoreTableViewCell: UITableViewCell {
    
    
    @IBOutlet var imageCell: UIImageView!
    
    @IBOutlet var addToTheBasket: UIButton!
    
    @IBOutlet var buyAProduct: UIButton!
    
    @IBOutlet var titleProduct: UILabel!
    
    @IBOutlet var priceProduct: UILabel!
  
    func addButtonsTarget(index:Int) {
        addToTheBasket.addTarget(self, action: #selector(putInABasket), for: .touchUpInside)
        buyAProduct.addTarget(self, action: #selector(buysTheProduct), for: .touchUpInside)
        number = index
    }
    
    var number:Int!
    
    @objc private func putInABasket() {
        print(number)
    }
    
    @objc private func buysTheProduct() {
        print("money")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: .init(top: 10, left: 8, bottom: 0, right: 8))
       
        imageCell.layer.cornerRadius = 10
        imageCell.clipsToBounds = true
       // imageCell.layer.masksToBounds = true

    }
    
}
