//
//  CustomCornerView.swift
//  HayStekAssignment
//
//  Created by Faseeh PM on 16/04/25.
//

import UIKit

@IBDesignable
class MyCustomCornerView: UIView {

    @IBInspectable var cornerStyle: Int = 0 {
        didSet {
            applyCornerStyle()
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 10 {
        didSet {
            applyCornerStyle()
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0.6 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        applyCornerStyle()
    }

    private func applyCornerStyle() {
        layer.masksToBounds = true

        switch cornerStyle {
        case 0:
            // All corners
            layer.cornerRadius = cornerRadius
            layer.borderColor = borderColor.cgColor
            layer.borderWidth = borderWidth
            layer.mask = nil

        case 1:
            // Top corners only
            roundCorners(corners: [.topLeft, .topRight], radius: cornerRadius)

        case 2:
            // Bottom corners only
            roundCorners(corners: [.bottomLeft, .bottomRight], radius: cornerRadius)

        case 3:
            // Circle
            layer.cornerRadius = min(bounds.width, bounds.height) / 2
            layer.borderColor = borderColor.cgColor
            layer.borderWidth = borderWidth
            layer.mask = nil

        case 4:
            // All corners with gray border
            layer.cornerRadius = cornerRadius
            layer.borderColor = UIColor.gray.cgColor
            layer.borderWidth = borderWidth
            layer.mask = nil

        default:
            break
        }
    }

    private func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        // Apply border color and width for partial corners
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }
}
