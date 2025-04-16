//
//  FlashSaleCVC.swift
//  HayStekAssignment
//
//  Created by Faseeh PM on 15/04/25.
//

import UIKit

class FlashSaleCVC: UICollectionViewCell {

    @IBOutlet weak var imgViewFavourite: UIImageView!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var imgViewProduct: UIImageView!
    @IBOutlet weak var widthContraintsOfTheView: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with product: Product) {
        lblProductName.text = product.title
        lblProductPrice.text = "$ \(product.price)"
        
        if let imageUrl = URL(string: product.image) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageUrl), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imgViewProduct.image = image
                    }
                }
            }
        }

        // Update favourite icon based on whether it's in cart
        let imageName = CartManager.shared.isInCart(product) ? "Favourite" : "UnFavourite"
        imgViewFavourite.image = UIImage(named: imageName)
    }

}
