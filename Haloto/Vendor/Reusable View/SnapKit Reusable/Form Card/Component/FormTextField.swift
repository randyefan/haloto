//
//  FormTextField.swift
//  Haloto
//
//  Created by Javier Fransiscus on 03/11/21.
//

import SnapKit
import UIKit

class FormTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    lazy var innerShadow: CALayer = {
        let innerShadow = CALayer()
        layer.addSublayer(innerShadow)
        return innerShadow
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        applyDesign()
        setFont()
    }

    func applyDesign() {
        innerShadow.frame = bounds

        // Shadow path (1pt ring around bounds)
        let radius = 5.0
        let path = UIBezierPath(roundedRect: innerShadow.bounds.insetBy(dx: -1, dy: -1), cornerRadius: radius)
        let cutout = UIBezierPath(roundedRect: innerShadow.bounds, cornerRadius: radius).reversing()

        path.append(cutout)
        innerShadow.shadowPath = path.cgPath
        innerShadow.masksToBounds = true
        // Shadow properties
        innerShadow.shadowColor = UIColor.darkGray.cgColor
        innerShadow.shadowOffset = CGSize(width: 0, height: 2)
        innerShadow.shadowOpacity = 1
        innerShadow.shadowRadius = 5
        innerShadow.cornerRadius = 5
    }
    
    func setFont(){
        self.font = UIFont(name: "Poppins-Regular", size: 12)
    }
}
