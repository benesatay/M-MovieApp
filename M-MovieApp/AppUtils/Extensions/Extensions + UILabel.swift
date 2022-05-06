//
//  Extensions + UILabel.swift
//  M-MovieApp
//
//  Created by Bahadır Enes Atay on 7.05.2022.
//

import UIKit

extension UILabel {
    func setColor(of substring: String, _ color: UIColor) {
        guard let text = self.text else { return }
        let range = (text as NSString).range(of: substring) as NSRange
        let attributedStr: NSMutableAttributedString = NSMutableAttributedString(string: text)
        attributedStr.addAttributes(
            [NSAttributedString.Key.foregroundColor : color],
            range: range
        )
        self.attributedText = attributedStr
    }
}
