//
//  CollectionViewCell.swift
//  SportsApp
//
//  Created by Mahmoud Mohamed Atrees on 11/09/2023.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    func customCorners(roundedCorners: UIRectCorner, radius: CGFloat, straightCorners: UIRectCorner, cutLength: CGFloat) {
        let roundPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: roundedCorners, cornerRadii: CGSize(width: radius, height: radius))
        let roundMask = CAShapeLayer()
        roundMask.path = roundPath.cgPath
        
        let straightPath = UIBezierPath()
        straightPath.move(to: CGPoint(x: 0, y: cutLength))
        
        if straightCorners.contains(.topLeft) {
            straightPath.addLine(to: CGPoint(x: cutLength, y: 0))
        } else {
            straightPath.addLine(to: .zero)
        }
        
        if straightCorners.contains(.topRight) {
            straightPath.addLine(to: CGPoint(x: self.bounds.width - cutLength, y: 0))
            straightPath.addLine(to: CGPoint(x: self.bounds.width, y: cutLength))
        } else {
            straightPath.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        }
        
        if straightCorners.contains(.bottomRight) {
            straightPath.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height - cutLength))
            straightPath.addLine(to: CGPoint(x: self.bounds.width - cutLength, y: self.bounds.height))
        } else {
            straightPath.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        }
        
        if straightCorners.contains(.bottomLeft) {
            straightPath.addLine(to: CGPoint(x: cutLength, y: self.bounds.height))
            straightPath.addLine(to: CGPoint(x: 0, y: self.bounds.height - cutLength))
        } else {
            straightPath.addLine(to: CGPoint(x: 0, y: self.bounds.height))
        }
        
        let straightMask = CAShapeLayer()
        straightMask.path = straightPath.cgPath
        
        let mask = CALayer()
        mask.addSublayer(roundMask)
        mask.addSublayer(straightMask)
        
        self.layer.mask = mask
    }



    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }

    func straightCutCorners(_ corners: UIRectCorner, cutLength: CGFloat) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: cutLength))
        
        if corners.contains(.topLeft) {
            path.addLine(to: CGPoint(x: cutLength, y: 0))
        } else {
            path.addLine(to: .zero)
        }
        
        if corners.contains(.topRight) {
            path.addLine(to: CGPoint(x: self.bounds.width - cutLength, y: 0))
            path.addLine(to: CGPoint(x: self.bounds.width, y: cutLength))
        } else {
            path.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        }
        
        if corners.contains(.bottomRight) {
            path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height - cutLength))
            path.addLine(to: CGPoint(x: self.bounds.width - cutLength, y: self.bounds.height))
        } else {
            path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        }
        
        if corners.contains(.bottomLeft) {
            path.addLine(to: CGPoint(x: cutLength, y: self.bounds.height))
            path.addLine(to: CGPoint(x: 0, y: self.bounds.height - cutLength))
        } else {
            path.addLine(to: CGPoint(x: 0, y: self.bounds.height))
        }
        
        path.close()
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
