//
//  CartManager.swift
//  ShoppingApp
//
//  Created by Faseeh PM on 16/04/25.
//

import Foundation
import UIKit

class CartManager {
    static let shared = CartManager()
    private let cartKey = "cartItems"
    private init() {}

    func getCartItems() -> [[String: Any]] {
        return UserDefaults.standard.array(forKey: cartKey) as? [[String: Any]] ?? []
    }

    func addToCart(_ product: Product) {
        var items = getCartItems()
        
        // Convert image to Data (if available), else use nil
        let imageData = product.image?.jpegData(compressionQuality: 1.0)

        // Create a dictionary with the product details
        let productDict: [String: Any] = [
            "id": product.id,
            "name": product.title,
            "price": product.price,
            "description": product.description,
            "rating": [
                "rate": product.rating.rate,
                "count": product.rating.count
            ],
            "image": imageData ?? Data()  // Store image as Data or an empty Data object if not available
        ]
        
        // Check if the product is already in the cart
        if !items.contains(where: { ($0["id"] as? Int) == product.id }) {
            items.append(productDict)
            save(items)
        }
    }

    func removeFromCart(_ product: Product) {
        var items = getCartItems()
        
        // Remove the product from the array based on ID
        items.removeAll { ($0["id"] as? Int) == product.id }
        
        save(items)
    }

    func isInCart(_ product: Product) -> Bool {
        return getCartItems().contains(where: { ($0["id"] as? Int) == product.id })
    }

    func clearCart() {
        UserDefaults.standard.removeObject(forKey: cartKey)
    }

    private func save(_ items: [[String: Any]]) {
        UserDefaults.standard.set(items, forKey: cartKey)
        NotificationCenter.default.post(name: .cartUpdated, object: nil)
    }
}
