//
//  TabNavigationMenu.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 01/11/21.
//

import UIKit

class TabNavigationMenu: UIImageView {
    
    var itemTapped: ((_ tab: Int) -> Void)?
    var activeItem: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(menuItems: [TabItem], frame: CGRect) {
        self.init(frame: frame)
        self.isUserInteractionEnabled = true
        self.clipsToBounds = true
        
        for i in 0 ..< menuItems.count {
            let itemWidth = self.frame.width / CGFloat(menuItems.count)
            let leadingAnchor = itemWidth * CGFloat(i)
            
            let itemView = self.createTabItem(item: menuItems[i], tag: 20 + i)
            itemView.tag = i
            
            self.addSubview(itemView)
            
            itemView.translatesAutoresizingMaskIntoConstraints = false
            itemView.backgroundColor = UIColor(hexString: "#F9F9F9")

            NSLayoutConstraint.activate([
                itemView.widthAnchor.constraint(equalToConstant: itemWidth),
                itemView.heightAnchor.constraint(equalTo: self.heightAnchor),

                itemView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingAnchor),
                itemView.topAnchor.constraint(equalTo: self.topAnchor),
            ])
        }
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
}

extension TabNavigationMenu {
    func createTabItem(item: TabItem, tag: Int) -> UIView {
        let tabBarItem = UIView(frame: CGRect.zero)
        let itemTitleLabel = UILabel(frame: CGRect.zero)
        let itemIconView = UIImageView(frame: CGRect.zero)
        
        itemTitleLabel.text = item.displayTitle
        itemTitleLabel.font = .systemFont(ofSize: 10)
        itemTitleLabel.textAlignment = .center
        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        itemTitleLabel.clipsToBounds = true
        itemTitleLabel.isHidden = false
        itemTitleLabel.numberOfLines = 0
        itemTitleLabel.tag = tag + 10
        itemTitleLabel.textColor = UIColor(hexString: "#B6B6B6")
        
        itemIconView.image = item.icon!.withRenderingMode(.automatic)
        itemIconView.tag = tag
        itemIconView.contentMode = .scaleAspectFit
        itemIconView.translatesAutoresizingMaskIntoConstraints = false
        itemIconView.clipsToBounds = true
        
        tabBarItem.addSubview(itemIconView)
        tabBarItem.addSubview(itemTitleLabel)
        tabBarItem.translatesAutoresizingMaskIntoConstraints = false
        tabBarItem.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            itemIconView.heightAnchor.constraint(equalToConstant: 24),
            itemIconView.widthAnchor.constraint(equalToConstant: 24),
            itemIconView.centerXAnchor.constraint(equalTo: tabBarItem.centerXAnchor),
            itemIconView.topAnchor.constraint(equalTo: tabBarItem.topAnchor, constant: 7),
            
            itemTitleLabel.centerXAnchor.constraint(equalTo: tabBarItem.centerXAnchor),
            itemTitleLabel.topAnchor.constraint(equalTo: itemIconView.bottomAnchor, constant: 8),
            itemTitleLabel.leftAnchor.constraint(lessThanOrEqualTo: tabBarItem.leftAnchor, constant: 4),
            itemTitleLabel.rightAnchor.constraint(lessThanOrEqualTo: tabBarItem.rightAnchor, constant: 4)
        ])
        
        tabBarItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap)))
        return tabBarItem
    }
    
    @objc func handleTap(_ sender: UIGestureRecognizer) {
        self.switchTab(from: self.activeItem, to: sender.view!.tag)
    }
    
    func switchTab(from: Int, to: Int) {
        self.deactivateTab(tab: from)
        self.activateTab(tab: to)
    }
    
    func activateTab(tab: Int) {
        self.itemTapped?(tab)
        self.activeItem = tab
    }
    
    func deactivateTab(tab: Int) {
        self.layoutIfNeeded()
    }
}
