//
//  Extension+NSAttributedString.swift
//  Haloto
//
//  Created by darindra.khadifa on 03/11/21.
//

import Foundation
import UIKit

public enum fontWeight {
    case bold
    case medium
    case regular

    var fontWeight: UIFont {
        switch self {
        case .bold:
            return UIFont(name: "Poppins-Bold", size: 1) ?? UIFont.systemFont(ofSize: 1)
        case .medium:
            return UIFont(name: "Poppins-Medium", size: 1) ?? UIFont.systemFont(ofSize: 1)
        case .regular:
            return UIFont(name: "Poppins-Regular", size: 1) ?? UIFont.systemFont(ofSize: 1)
        }
    }
}

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

    public class func font(_ string: String, size: CGFloat, fontWeight: fontWeight = .regular, color: UIColor = .black, alignment: NSTextAlignment = .left, isTitle: Bool = false) -> NSAttributedString {
        let attribute = NSAttributedString.setFont(
            font: fontWeight.fontWeight.withSize(size),
            kerning: isTitle ? 0 : 0.5,
            color: color,
            lineSpacing: 5,
            alignment: alignment
        )
        let attributeString = NSMutableAttributedString(string: string, attributes: attribute)
        return attributeString
    }
}
