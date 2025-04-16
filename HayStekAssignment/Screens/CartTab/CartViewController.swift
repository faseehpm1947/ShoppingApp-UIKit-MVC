//
//  CartViewController.swift
//  HayStekAssignment
//
//  Created by Faseeh PM on 15/04/25.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var btnCheckout: UIButton!
    @IBOutlet weak var tableViewCartList: UITableView!
    
    var cartItems: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibFiles()
        setupObserver()
        reloadCart()
        btnCheckout.roundAllCorners(radius: 10)
    }

    @objc func reloadCart() {
        cartItems = CartManager.shared.getCartItems()
        tableViewCartList.reloadData()
        btnCheckout.isEnabled = !cartItems.isEmpty
        btnCheckout.alpha = cartItems.isEmpty ? 0.5 : 1.0
    }
    func registerNibFiles(){
        tableViewCartList.register(UINib(nibName: "CartListTVC", bundle: nil), forCellReuseIdentifier: "CartListTVC")
    }
    func setupObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCart), name: .cartUpdated, object: nil)
    }
    @IBAction func checkoutTapped(_ sender: Any) {
        
        CartManager.shared.clearCart()
        NotificationCenter.default.post(name: .cartUpdated, object: nil)
        
        let successBottomsheet = CheckoutBottomSheetVC.instantiate()
        self.presentBottomSheetWithHeight(ViewController: successBottomsheet, height: 0.36)
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = cartItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartListTVC", for: indexPath) as! CartListTVC
        cell.configure(with: product)
        cell.onFavouriteTapped = {
            CartManager.shared.removeFromCart(product)
        }
        return cell
    }
}
