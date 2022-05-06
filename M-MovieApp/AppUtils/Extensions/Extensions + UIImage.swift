//
//  Extensions + UIImage.swift
//  M-MovieApp
//
//  Created by Bahadır Enes Atay on 6.05.2022.
//

import UIKit

extension UIImage {
    class func setIcon(_ icon: Constants.Icon) -> UIImage {
        return UIImage(named: icon.rawValue) ?? UIImage()
    }
}
