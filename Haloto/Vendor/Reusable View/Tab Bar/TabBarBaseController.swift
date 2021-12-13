//
//  TabBarBaseController.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 01/11/21.
//

import UIKit
import MapKit

class TabBarBaseController: UITabBarController {
    var customTabBar: TabNavigationMenu!
    var tabBarHeight: CGFloat = 83
    
    var productLogin: ProductLogin?
    
    init(productLogin: ProductLogin) {
        self.productLogin = productLogin
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTabBar()
    }
    
    private func loadTabBar() {
        switch productLogin {
        case .User:
            let tabItems: [TabItem] = [.overview, .consult]
            self.setupCustomTabBar(tabItems) { (controllers) in
                self.viewControllers = controllers
            }
            self.selectedIndex = 0
            setTabActive(tag: 0 + 20)
        case .Bengkel:
            let tabItems: [TabItem] = [.profile, .booking, .consult]
            self.setupCustomTabBar(tabItems) { (controllers) in
                self.viewControllers = controllers
            }
            self.selectedIndex = 0
            setTabActive(tag: 0 + 20)
        case .none:
            break
        }
    }
    
    private func setupCustomTabBar(_ items: [TabItem], completion: @escaping ([UIViewController]) -> Void) {
        let frame = CGRect(x: tabBar.frame.origin.x, y: tabBar.frame.origin.x, width: tabBar.frame.width, height: tabBarHeight)
        var controllers = [UIViewController]()
        
        tabBar.isHidden = true
        self.customTabBar = TabNavigationMenu(menuItems: items, frame: frame)
        self.customTabBar.translatesAutoresizingMaskIntoConstraints = false
        self.customTabBar.clipsToBounds = true
        self.customTabBar.itemTapped = self.changeTab
        self.customTabBar.tag = 700
        self.view.addSubview(customTabBar)
        
        NSLayoutConstraint.activate([
            self.customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            self.customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            self.customTabBar.widthAnchor.constraint(equalToConstant: tabBar.frame.width),
            self.customTabBar.heightAnchor.constraint(equalToConstant: tabBarHeight),
            self.customTabBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        self.view.layoutIfNeeded()
        self.view.bringSubviewToFront(customTabBar)
        for i in 0 ..< items.count {
            controllers.append(items[i].viewController)
        }
        
        self.view.layoutIfNeeded()
        
        completion(controllers)
    }
    
    private func changeTab(tab: Int) {
        setTabActive(tag: tab + 20)
        self.selectedIndex = tab
    }
    
    private func setTabActive(tag: Int) {
        switch productLogin {
        case .User:
            
            if let profileIcon = customTabBar.viewWithTag(23) as? UIImageView, let consultIcon = customTabBar.viewWithTag(21) as? UIImageView, let bookingIcon = customTabBar.viewWithTag(22) as? UIImageView, let overviewIcon =  customTabBar.viewWithTag(20) as? UIImageView {
                if let profileLabel = customTabBar.viewWithTag(33) as? UILabel, let bookingLabel = customTabBar.viewWithTag(32) as? UILabel, let consultLabel = customTabBar.viewWithTag(31) as? UILabel, let overviewLabel = customTabBar.viewWithTag(30) as? UILabel {
                    if tag == 20 {
                        profileIcon.image = UIImage(named: "icon_person_inactive") ?? UIImage()
                        consultIcon.image = UIImage(named: "icon_chat_inactive") ?? UIImage()
                        bookingIcon.image = UIImage(named: "icon_circle_inactive") ?? UIImage()
                        overviewIcon.image = UIImage(named: "icon_robot_active") ?? UIImage()
                        
                        profileLabel.textColor = UIColor(hexString: "#B6B6B6")
                        bookingLabel.textColor = UIColor(hexString: "#B6B6B6")
                        consultLabel.textColor = UIColor(hexString: "#B6B6B6")
                        overviewLabel.textColor = UIColor(hexString: "#7EA1D6")
                    } else if tag == 21 {
                        profileIcon.image = UIImage(named: "icon_person_inactive") ?? UIImage()
                        consultIcon.image = UIImage(named: "icon_chat_active") ?? UIImage()
                        bookingIcon.image = UIImage(named: "icon_circle_inactive") ?? UIImage()
                        overviewIcon.image = UIImage(named: "icon_robot_inactive") ?? UIImage()
                        
                        profileLabel.textColor = UIColor(hexString: "#B6B6B6")
                        bookingLabel.textColor = UIColor(hexString: "#B6B6B6")
                        consultLabel.textColor = UIColor(hexString: "#7EA1D6")
                        overviewLabel.textColor = UIColor(hexString: "#B6B6B6")
                    } else if tag == 22 {
                        profileIcon.image = UIImage(named: "icon_person_inactive") ?? UIImage()
                        consultIcon.image = UIImage(named: "icon_chat_inactive") ?? UIImage()
                        bookingIcon.image = UIImage(named: "icon_circle_active") ?? UIImage()
                        overviewIcon.image = UIImage(named: "icon_robot_inactive") ?? UIImage()
                        
                        profileLabel.textColor = UIColor(hexString: "#B6B6B6")
                        bookingLabel.textColor = UIColor(hexString: "#7EA1D6")
                        consultLabel.textColor = UIColor(hexString: "#B6B6B6")
                        overviewLabel.textColor = UIColor(hexString: "#B6B6B6")
                    } else if tag == 23 {
                        profileIcon.image = UIImage(named: "icon_person_active") ?? UIImage()
                        consultIcon.image = UIImage(named: "icon_chat_inactive") ?? UIImage()
                        bookingIcon.image = UIImage(named: "icon_circle_inactive") ?? UIImage()
                        overviewIcon.image = UIImage(named: "icon_robot_inactive") ?? UIImage()
                        
                        profileLabel.textColor = UIColor(hexString: "#7EA1D6")
                        bookingLabel.textColor = UIColor(hexString: "#B6B6B6")
                        consultLabel.textColor = UIColor(hexString: "#B6B6B6")
                        overviewLabel.textColor = UIColor(hexString: "#B6B6B6")
                    }
                }
            }
        case .Bengkel:
            if let profileIcon = customTabBar.viewWithTag(20) as? UIImageView, let consultIcon = customTabBar.viewWithTag(22) as? UIImageView, let bookingIcon = customTabBar.viewWithTag(21) as? UIImageView {
                if let profileLabel = customTabBar.viewWithTag(30) as? UILabel, let bookingLabel = customTabBar.viewWithTag(31) as? UILabel, let consultLabel = customTabBar.viewWithTag(32) as? UILabel {
                    if tag == 20 {
                        profileIcon.image = UIImage(named: "icon_person_active") ?? UIImage()
                        consultIcon.image = UIImage(named: "icon_chat_inactive") ?? UIImage()
                        bookingIcon.image = UIImage(named: "icon_circle_inactive") ?? UIImage()
                        
                        profileLabel.textColor = UIColor(hexString: "#7EA1D6")
                        bookingLabel.textColor = UIColor(hexString: "#B6B6B6")
                        consultLabel.textColor = UIColor(hexString: "#B6B6B6")
                    } else if tag == 21 {
                        profileIcon.image = UIImage(named: "icon_person_inactive") ?? UIImage()
                        consultIcon.image = UIImage(named: "icon_chat_inactive") ?? UIImage()
                        bookingIcon.image = UIImage(named: "icon_circle_active") ?? UIImage()
                        
                        profileLabel.textColor = UIColor(hexString: "#B6B6B6")
                        bookingLabel.textColor = UIColor(hexString: "#7EA1D6")
                        consultLabel.textColor = UIColor(hexString: "#B6B6B6")
                    } else if tag == 22 {
                        profileIcon.image = UIImage(named: "icon_person_inactive") ?? UIImage()
                        consultIcon.image = UIImage(named: "icon_chat_active") ?? UIImage()
                        bookingIcon.image = UIImage(named: "icon_circle_inactive") ?? UIImage()
                        
                        profileLabel.textColor = UIColor(hexString: "#B6B6B6")
                        bookingLabel.textColor = UIColor(hexString: "#B6B6B6")
                        consultLabel.textColor = UIColor(hexString: "#7EA1D6")
                    } 
                }
            }
        case .none:
            break
        }
    }
}
