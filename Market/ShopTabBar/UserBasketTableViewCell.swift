import UIKit

class UserBasketTableViewCell: UITableViewCell {
    
    
    @IBOutlet private var imageProduct: UIImageView!
    @IBOutlet private var titleProduct: UILabel!
    @IBOutlet private var priceProduct: UILabel!
    
    @IBOutlet private var chooiseProduct: UIButton!
    
    
    func addButton() {
        chooiseProduct.addTarget(self, action: #selector(touchButton), for: .touchUpInside)
        
    }
    
    @objc private func touchButton() {
        chooiseProduct.isSelected = !chooiseProduct.isSelected
        if chooiseProduct.isSelected {
            chooiseProduct.setImage(UIImage(named: "chooiseCircle"), for: .selected)

        } else {
            chooiseProduct.setImage(UIImage(named: "circle"), for: .selected)
        }
    }
    
}
