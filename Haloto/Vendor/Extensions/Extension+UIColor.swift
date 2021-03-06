//
//  Extension+UIColor.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 26/10/21.
//

import UIKit

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }

    static var primary: UIColor {
        get {
            return UIColor(hexString: "#04D474")
        }
    }

    static var backgroundUpcomingMaintenanceCell: UIColor {
        get {
            return UIColor(hexString: "#7EA1D6")
        }
    }

    static var blackApp: UIColor {
        get {
            return UIColor(hexString: "#616161")
        }
    }

    static var greyApp: UIColor {
        get {
            return UIColor(hexString: "#E0E0E0")
        }
    }

    static var secondaryGreyApp: UIColor {
        get {
            return UIColor(hexString: "#A0A0A0")
        }
    }

    static var blueApp: UIColor {
        get {
            return UIColor(hexString: "#7EA1D6")
        }
    }

    static var secondaryBlueApp: UIColor {
        get {
            return UIColor(hexString: "#CCDAEF")
        }
    }

    static var buttonYellow: UIColor {
        get {
            return UIColor(hexString: "#FFC940")
        }
    }

    static var cardTextDefault: UIColor {
        get {
            return UIColor(hexString: "#858585")
        }
    }

    public static var backgroundOverlay: UIColor {
        get {
            return UIColor(hexString: "#2E3137").withAlphaComponent(0.7)
        }
    }
}
