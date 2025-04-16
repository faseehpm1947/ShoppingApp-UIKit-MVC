//
//  CheckoutBottomSheetVC.swift
//  HayStekAssignment
//
//  Created by Faseeh PM on 16/04/25.
//

import UIKit

class CheckoutBottomSheetVC: UIViewController {
    @IBOutlet weak var btnDone: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnDone.roundAllCorners(radius: 10)

    }
    static func instantiate() -> CheckoutBottomSheetVC {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let checkoutVC = storyboard.instantiateViewController(withIdentifier: "CheckoutBottomSheetVC") as? CheckoutBottomSheetVC else {
           fatalError("CheckoutBottomSheetVC not found in storyboard")
        }
        return checkoutVC
    }
    @IBAction func doneTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
