//
//  CategoriesCVC.swift
//  ShoppingApp
//
//  Created by Faseeh PM on 15/04/25.
//

import UIKit

class CategoriesCVC: UICollectionViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var viewImageBg: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewImageBg.layer.cornerRadius = viewImageBg.frame.size.width / 2
        viewImageBg.clipsToBounds = true
        // Initialization code
    }
    func configure(with category: Category) {
        lblName.text = category.name
        imgView.image = category.image
    }

}
