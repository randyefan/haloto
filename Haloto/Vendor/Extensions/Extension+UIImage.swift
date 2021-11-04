//
//  Extension+UIImage.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/4/21.
//

import Foundation
import UIKit

extension UIImage {
    static var emailImage: UIImage {
        return UIImage(systemName: "envelope.fill") ?? UIImage.remove
    }

    static var phoneImage: UIImage {
        return UIImage(systemName: "phone.fill") ?? UIImage.remove
    }
    
    static var editImage: UIImage {
        return UIImage(named: "edit-button-placeholder") ?? UIImage.remove
    }
    
    static var backgroundProfile: UIImage {
        return UIImage(named: "profile-background") ?? UIImage.remove
    }
}
