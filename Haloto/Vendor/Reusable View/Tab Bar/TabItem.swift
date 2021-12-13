//
//  TabItem.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 01/11/21.
//

import Foundation
import UIKit

enum TabItem: String, CaseIterable {
    case profile = "Profile"
    case overview = "Dashboard"
    case consult = "Emergency"
    case booking = "Booking"
    case account = "Account"
    
    var viewController: UIViewController {
        switch self {
        case .profile:
            let vc = UIViewController()
            vc.title = ""
            vc.view.backgroundColor = .white
            let navigation = UINavigationController(rootViewController: vc)
            return navigation
        case .overview:
            let vc = OverviewViewController()
            vc.title = ""
            vc.view.backgroundColor = .white
            let navigation = UINavigationController(rootViewController: vc)
            return navigation
        case .consult:
            let vc = ConsultViewController()
            vc.title = ""
            let navigation = UINavigationController(rootViewController: vc)
            return navigation
        case .booking:
            let vc = UIViewController()
            vc.title = ""
            vc.view.backgroundColor = .white
            let navigation = UINavigationController(rootViewController: vc)
            return navigation
        case .account:
            let vc = UIViewController()
            vc.title = ""
            vc.view.backgroundColor = .white
            let navigation = UINavigationController(rootViewController: vc)
            return navigation
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .profile:
            return UIImage(named: "icon_person_inactive") ?? UIImage()
        case .overview:
            return UIImage(named: "icon_robot_inactive") ?? UIImage()
        case .consult, .account:
            return UIImage(named: "icon_chat_inactive") ?? UIImage()
        case .booking:
            return UIImage(named: "icon_circle_inactive") ?? UIImage()
        }
    }
    
    var displayTitle: String {
        return self.rawValue
    }
}
