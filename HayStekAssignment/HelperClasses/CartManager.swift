//
//  CartManager.swift
//  HayStekAssignment
//
//  Created by Faseeh PM on 16/04/25.
//

import Foundation

import Foundation

class CartManager {
    static let shared = CartManager()
    private let cartKey = "cartItems"
    private init() {}

    func getCartItems() -> [Product] {
        if let data = UserDefaults.standard.data(forKey: cartKey),
           let items = try? JSONDecoder().decode([Product].self, from: data) {
            return items
        }
        return []
    }

    func addToCart(_ product: Product) {
        var items = getCartItems()
        if !items.contains(where: { $0.id == product.id }) {
            items.append(product)
            save(items)
        }
    }

    func removeFromCart(_ product: Product) {
        var items = getCartItems()
        items.removeAll { $0.id == product.id }
        save(items)
    }

    func isInCart(_ product: Product) -> Bool {
        return getCartItems().contains(where: { $0.id == product.id })
    }
    
    func clearCart() {
        UserDefaults.standard.removeObject(forKey: cartKey)
    }

    private func save(_ items: [Product]) {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: cartKey)
            NotificationCenter.default.post(name: .cartUpdated, object: nil)
        }
    }
}
