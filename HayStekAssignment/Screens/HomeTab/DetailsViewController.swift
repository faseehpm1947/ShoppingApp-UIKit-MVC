//
//  DetailsViewController.swift
//  HayStekAssignment
//
//  Created by Faseeh PM on 16/04/25.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var btnFavourite: UIButton!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblRatingCount: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var imgViewProduct: UIImageView!
    
    var flashSaleProduct: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let product = flashSaleProduct else { return }
            
        lblProductName.text = product.title
        lblPrice.text = "$ \(product.price)"
        lblDescription.text = product.description
        lblRating.text = "⭐️ \(product.rating.rate)"
        lblRatingCount.text = "(\(product.rating.count) reviews)"
        
        if let imageUrl = URL(string: product.image) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageUrl),
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imgViewProduct.image = image
                    }
                }
            }
        }

    }
    
    static func instantiate() -> DetailsViewController{
        guard let detailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else
        { fatalError("Unexpectedly failed getting DetailsViewController from Storyboard") }
        return detailsVC
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func favouriteTapped(_ sender: Any) {
    }
    
}
