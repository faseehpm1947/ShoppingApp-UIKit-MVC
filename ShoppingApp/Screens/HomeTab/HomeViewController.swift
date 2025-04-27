//
//  HomeViewController.swift
//  ShoppingApp
//
//  Created by Faseeh PM on 15/04/25.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionViewFlashSales: UICollectionView!
    @IBOutlet weak var collectionViewCategories: UICollectionView!
    
    var categories: [Category]? = [Category(name: "Phones",image: UIImage(named: "Mobiles")),Category(name: "Consoles",image: UIImage(named: "Consoles")),Category(name: "Laptops",image: UIImage(named: "Laptops")),Category(name: "Cameras",image: UIImage(named: "Cameras")),Category(name: "Earphones",image: UIImage(named: "Earphones"))]
        
    var flashSaleProducts: [Product] = [Product(id: 1, title: "Tshirt", price: 99, description: "This versatile solid T-shirt is crafted from 100% premium cotton for ultimate comfort and breathability. Designed for everyday wear, it features a classic crew neck, short sleeves, and a regular fit that suits all body types. Perfect for layering or wearing on its own, this T-shirt offers a soft feel against the skin and holds its shape after multiple washes.", image: UIImage(named: "Tshirt"), rating: Rating(rate: 4.2, count: 122)), Product(id: 2, title: "Pant", price: 149, description: "These solid cotton twill pants are designed for all-day comfort and effortless style. Crafted from durable, breathable fabric with a hint of stretch, they offer a clean look suitable for casual and semi-formal occasions. The pants feature a mid-rise waist, straight legs, and a flat front design for a classic fit that never goes out of style.", image: UIImage(named: "Pant"), rating: Rating(rate: 3.4, count: 77))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        regiterNibFiles()
        setupObserver()
    }
    
    @objc func cartUpdated() {
        collectionViewFlashSales.reloadData()
    }
    
    func regiterNibFiles(){
        collectionViewCategories.register(UINib(nibName: "CategoriesCVC", bundle: nil), forCellWithReuseIdentifier: "CategoriesCVC")
        collectionViewFlashSales.register(UINib(nibName: "FlashSaleCVC", bundle: nil), forCellWithReuseIdentifier: "FlashSaleCVC")
    }
    func setupObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(cartUpdated), name: .cartUpdated, object: nil)
    }
    

    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case collectionViewCategories:
            return categories?.count ?? 0
        case collectionViewFlashSales:
            return min(flashSaleProducts.count, 2)
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case collectionViewCategories:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCVC", for: indexPath) as! CategoriesCVC
            if let category = categories?[indexPath.item] {
                cell.configure(with: category)
            }
            return cell

        case collectionViewFlashSales:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlashSaleCVC", for: indexPath) as! FlashSaleCVC
            cell.widthContraintsOfTheView.constant = (collectionView.frame.size.width / 2) - 6
            let product = flashSaleProducts[indexPath.item]
            cell.configure(with: product)
            return cell
            
        default:
            return UICollectionViewCell()
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewFlashSales{
            let detailsVC = DetailsViewController.instantiate()
            detailsVC.flashSaleProduct = flashSaleProducts[indexPath.item]
            detailsVC.modalPresentationStyle = .fullScreen
            self.present(detailsVC, animated: true)
        }
    }
    
}
