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
    internal class func setFont(
        font: UIFont,
        kerning: Double = 0,
        color: UIColor,
        lineSpacing: CGFloat? = nil,
        alignment: NSTextAlignment,
        underline: Bool
    ) -> [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        if let lineSpacing = lineSpacing {
            paragraphStyle.lineSpacing = lineSpacing
        }
        paragraphStyle.alignment = alignment

        var attribute = [.font: font,
                .kern: kerning,
                .foregroundColor: color,
                .paragraphStyle: paragraphStyle] as [NSAttributedString.Key: Any]

        if underline {
            attribute[.underlineColor] = color
            attribute[.underlineStyle] = NSUnderlineStyle.thick.rawValue
        }

        return attribute
    }

    public class func font(
        _ string: String,
        size: CGFloat,
        fontWeight: fontWeight = .regular,
        color: UIColor = .black,
        lineSpacing: CGFloat = 16,
        alignment: NSTextAlignment = .left,
        underline: Bool = false,
        isTitle: Bool = false
    ) -> NSAttributedString {
        let attribute = NSAttributedString.setFont(
            font: fontWeight.fontWeight.withSize(size),
            kerning: isTitle ? 0 : 0.5,
            color: color,
            lineSpacing: lineSpacing,
            alignment: alignment,
            underline: underline
        )
        let attributeString = NSMutableAttributedString(string: string, attributes: attribute)
        return attributeString
    }

    public class func fontWithAttachment(
        _ string: String,
        size: CGFloat,
        fontWeight: fontWeight = .regular,
        color: UIColor = .black,
        alignment: NSTextAlignment = .left,
        underline: Bool = false,
        isTitle: Bool = false,
        prefixAttachment: NSTextAttachment? = nil,
        suffixAttachment: NSTextAttachment? = nil
    )
        -> NSMutableAttributedString?
    {
        let out = NSMutableAttributedString()

        if let attach = prefixAttachment {
            let stringAttachment = NSAttributedString(attachment: attach)
            out.append(stringAttachment)
        }

        let attribute = NSAttributedString.setFont(
            font: fontWeight.fontWeight.withSize(size),
            kerning: isTitle ? 0 : 0.5,
            color: color,
            lineSpacing: 0,
            alignment: alignment,
            underline: underline
        )

        let stringAttribute = NSAttributedString(string: string, attributes: attribute)
        out.append(stringAttribute)

        if let attach = suffixAttachment {
            let stringAttachment = NSAttributedString(attachment: attach)
            out.append(stringAttachment)
        }

        return out
    }
}
