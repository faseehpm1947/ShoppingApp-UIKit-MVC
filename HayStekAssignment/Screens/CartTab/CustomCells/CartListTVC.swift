//
//  CartListTVC.swift
//  HayStekAssignment
//
//  Created by Faseeh PM on 16/04/25.
//

import UIKit

class CartListTVC: UITableViewCell {

    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var onFavouriteTapped: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with product: Product) {
        lblTitle.text = product.title
        lblPrice.text = "$\(product.price)"
        btnFavorite.setImage(UIImage(systemName: "Favouritex"), for: .normal)

        if let url = URL(string: product.image) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imgView.image = image
                    }
                }
            }
        }
    }

    @IBAction func favTapped(_ sender: Any) {
        onFavouriteTapped?()
    }
}
