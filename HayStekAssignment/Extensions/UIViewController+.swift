//
//  UIViewController+.swift
//  HayStekAssignment
//
//  Created by Faseeh PM on 16/04/25.
//

import Foundation
import UIKit

extension UIViewController{
    func presentBottomSheetWithHeight(ViewController: UIViewController, height: Double){
        let nav = UINavigationController(rootViewController: ViewController)
        nav.modalPresentationStyle = .pageSheet
        if #available(iOS 16.0, *) {
            if let sheet = nav.sheetPresentationController {
                sheet.detents = [.custom(resolver: { context in height * context.maximumDetentValue})]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 16
            }
        } else {
            // Fallback on earlier versions
        }
        self.present(nav, animated: true)
    }
}
