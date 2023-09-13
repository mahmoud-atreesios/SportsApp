//
//  Draft.swift
//  SportsApp
//
//  Created by Mahmoud Mohamed Atrees on 11/09/2023.
//

import Foundation
import UIKit

extension UIImageView {
    func makeRounded() {
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }
}

class PaddingLabel: UILabel {
    var edgeInsets = UIEdgeInsets(top: 5, left: 7, bottom: 5, right: 7)

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: edgeInsets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + edgeInsets.left + edgeInsets.right,
                      height: size.height + edgeInsets.top + edgeInsets.bottom)
    }
}

extension UITableViewCell{
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
