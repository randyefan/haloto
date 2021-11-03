//
//  Extension+UIEdgeInsets.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 04/11/21.
//

import Foundation
import UIKit

extension CGFloat {
#if os(iOS) || os(tvOS)
    static var topSafeArea: CGFloat {
        let window = UIApplication.shared.windows.first
        return window?.safeAreaInsets.top ?? 0
    }
#endif
    
#if os(iOS) || os(tvOS)
    static var bottomSafeArea: CGFloat {
        let window = UIApplication.shared.windows.first
        return window?.safeAreaInsets.bottom ?? 0
    }
#endif
}
