//
//  Extension+NSAttributedString.swift
//  Haloto
//
//  Created by darindra.khadifa on 03/11/21.
//

import Foundation
import UIKit

private let poppinsBold = UIFont(name: "Poppins-Bold", size: 1) ?? UIFont.systemFont(ofSize: 1)
private let poppinsRegular = UIFont(name: "Poppins-Regular", size: 1) ?? UIFont.systemFont(ofSize: 1)
private let poppinsMedium = UIFont(name: "Poppins-Medium", size: 1) ?? UIFont.systemFont(ofSize: 1)

private let headingSize: CGFloat = 18
private let bodySize: CGFloat = 12
private let captionSize: CGFloat = 11


extension NSAttributedString {
    internal class func setFont(font: UIFont, kerning: Double = 0, color: UIColor, lineSpacing: CGFloat? = nil, alignment: NSTextAlignment) -> [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        if let lineSpacing = lineSpacing {
            paragraphStyle.lineSpacing = lineSpacing
        }
        paragraphStyle.alignment = alignment

        let attribute = [.font: font,
                .kern: kerning,
                .foregroundColor: color,
                .paragraphStyle: paragraphStyle] as [NSAttributedString.Key: Any]

        return attribute
    }

    public class func heading(_ string: String, color: UIColor = .black, alignment: NSTextAlignment = .left) -> NSAttributedString {
        let attribute = NSAttributedString.setFont(
            font: poppinsBold.withSize(headingSize),
            color: color,
            lineSpacing: 0,
            alignment: alignment
        )
        let attributeString = NSMutableAttributedString(string: string, attributes: attribute)
        return attributeString
    }

    public class func body(_ string: String,
        color: UIColor = .black,
        alignment: NSTextAlignment = .left) -> NSAttributedString {
        let attribute = NSAttributedString.setFont(
            font: poppinsRegular.withSize(bodySize),
            kerning: 16,
            color: color,
            lineSpacing: 0,
            alignment: alignment
        )

        let attributeString = NSMutableAttributedString(string: string, attributes: attribute)
        return attributeString
    }

    public class func caption(_ string: String,
        color: UIColor = .black,
        alignment: NSTextAlignment = .left) -> NSAttributedString {
        let attribute = NSAttributedString.setFont(
            font: poppinsMedium.withSize(captionSize),
            kerning: 16,
            color: color,
            lineSpacing: 0,
            alignment: alignment
        )

        let attributeString = NSMutableAttributedString(string: string, attributes: attribute)
        return attributeString
    }

    public class func button(_ string: String,
        color: UIColor = .black,
        alignment: NSTextAlignment = .left) -> NSAttributedString {
        let attribute = NSAttributedString.setFont(
            font: poppinsRegular.withSize(captionSize),
            kerning: 16,
            color: color,
            lineSpacing: 0,
            alignment: alignment
        )

        let attributeString = NSMutableAttributedString(string: string, attributes: attribute)
        return attributeString
    }
}
