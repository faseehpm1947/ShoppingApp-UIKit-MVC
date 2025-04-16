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
        setupUI()
    }
    static func instantiate() -> DetailsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else {
           fatalError("DetailsViewController not found in storyboard")
        }
        return vc
    }

    func setupUI() {
       guard let product = flashSaleProduct else { return }
       lblProductName.text = product.title
       lblPrice.text = "$ \(product.price)"
       lblDescription.text = product.description
       lblRating.text = "⭐️ \(product.rating.rate)"
       lblRatingCount.text = "(\(product.rating.count) reviews)"

       if let url = URL(string: product.image) {
           DispatchQueue.global().async {
               if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                   DispatchQueue.main.async {
                       self.imgViewProduct.image = image
                   }
               }
           }
       }

       updateFavouriteButton()
    }

    func updateFavouriteButton() {
        let feedbackGenerator = UISelectionFeedbackGenerator()
        feedbackGenerator.selectionChanged()
        guard let product = flashSaleProduct else { return }
        let imageName = CartManager.shared.isInCart(product) ? "Favourite" : "UnFavourite"
        btnFavourite.setImage(UIImage(named: imageName), for: .normal)
    }
    
    @IBAction func favouriteTapped(_ sender: Any) {
       guard let product = flashSaleProduct else { return }

       if CartManager.shared.isInCart(product) {
           CartManager.shared.removeFromCart(product)
       } else {
           CartManager.shared.addToCart(product)
       }

       updateFavouriteButton()
        
       NotificationCenter.default.post(name: .cartUpdated, object: nil)

        
    }

    @IBAction func backTapped(_ sender: Any) {
       self.dismiss(animated: true)
    }

    
}
