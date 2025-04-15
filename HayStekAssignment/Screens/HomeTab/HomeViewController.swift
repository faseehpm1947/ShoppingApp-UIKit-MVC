//
//  HomeViewController.swift
//  HayStekAssignment
//
//  Created by Faseeh PM on 15/04/25.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionViewFlashSales: UICollectionView!
    @IBOutlet weak var collectionViewCategories: UICollectionView!
    
    var categories: [Category]? = [Category(name: "Phones",image: UIImage(named: "Mobiles")),Category(name: "Consoles",image: UIImage(named: "Consoles")),Category(name: "Laptops",image: UIImage(named: "Laptops")),Category(name: "Cameras",image: UIImage(named: "Cameras")),Category(name: "Earphones",image: UIImage(named: "Earphones"))]
    var flashSaleProducts: [Product] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewCategories.register(UINib(nibName: "CategoriesCVC", bundle: nil), forCellWithReuseIdentifier: "CategoriesCVC")
        collectionViewFlashSales.register(UINib(nibName: "FlashSaleCVC", bundle: nil), forCellWithReuseIdentifier: "FlashSaleCVC")
        getFalshSaleDetails()

    }
    
    func getFalshSaleDetails() {
        guard let url = URL(string: "https://fakestoreapi.com/products") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("API Error: \(error)")
                return
            }

            guard let data = data else { return }

            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                self.flashSaleProducts = products

                DispatchQueue.main.async {
                    self.collectionViewFlashSales.reloadData()
                }
            } catch {
                print("Decoding Error: \(error)")
            }
        }.resume()
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
            let category = categories?[indexPath.item]
            cell.imgView.image = category?.image
            cell.lblName.text = category?.name
            return cell
        case collectionViewFlashSales:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlashSaleCVC", for: indexPath) as! FlashSaleCVC
            cell.widthContraintsOfTheView.constant = (collectionView.frame.size.width / 2) - 6
            
            let product = flashSaleProducts[indexPath.item]
            cell.lblProductName.text = product.title
            cell.lblProductPrice.text = "$ \(product.price)"

            if let imageUrl = URL(string: product.image) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: imageUrl), let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            if let currentIndex = collectionView.indexPath(for: cell), currentIndex == indexPath {
                                cell.imgViewProduct.image = image
                            }
                        }
                    }
                }
            }

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
