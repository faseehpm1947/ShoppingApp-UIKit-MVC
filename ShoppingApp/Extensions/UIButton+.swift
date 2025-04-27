//
//  UIButton+.swift
//  ShoppingApp
//
//  Created by Faseeh PM on 16/04/25.
//

import Foundation
import UIKit

extension UIButton{
    func roundAllCorners(radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
    }
}
