//
//  Product.swift
//  ShoppingApp
//
//  Created by Faseeh PM on 16/04/25.
//

import Foundation
import UIKit

struct Product {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let image: UIImage?
    let rating: Rating
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}
