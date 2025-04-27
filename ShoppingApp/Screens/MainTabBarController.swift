//
//  MainTabBarController.swift
//  ShoppingApp
//
//  Created by Faseeh PM on 16/04/25.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateCartBadge), name: .cartUpdated, object: nil)
        updateCartBadge()
    }
    @objc func updateCartBadge() {
        let count = CartManager.shared.getCartItems().count
        let cartTabIndex = 1 // Change if your cart is at a different index
        if cartTabIndex < viewControllers?.count ?? 0 {
            let cartTab = tabBar.items?[cartTabIndex]
            cartTab?.badgeValue = count > 0 ? "\(count)" : nil
            cartTab?.badgeColor = .systemRed
        }
    }
}
