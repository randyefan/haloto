//
//  VehicleDescriptionNode.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/2/21.
//

import AsyncDisplayKit
import Foundation

class VehicleDescriptionNode: ASDisplayNode {
     private let vehicle: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()
    
    private let vehicleDetails1: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()
    
    private let vehicleDetails2: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()
    
    private let isDefault: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()
    
    init(model: Vehicle) {
        //if let fontBold = UIFont.init(name: "Poppins-Bold.ttf", size: 20) {
            vehicle.attributedText = NSAttributedString(string: "\(model.manufacture) \(model.name)", attributes: [
                .font : UIFont.boldSystemFont(ofSize: 20),
                .foregroundColor : UIColor.black
                ]
            )
        //}
        
        vehicleDetails1.attributedText = NSAttributedString(string: "\(model.manufacturedYear) | \(model.transmissionType) | \(model.capacity) ", attributes: [
            .font : UIFont.systemFont(ofSize: 12, weight: .regular),
            .foregroundColor : UIColor.black
            ]
        )
        
        vehicleDetails2.attributedText = NSAttributedString(string: "\(model.fuelType) | \(model.licensePlate)", attributes: [
            .font : UIFont.systemFont(ofSize: 12, weight: .regular),
            .foregroundColor : UIColor.black
            ]
        )
        isDefault.attributedText = NSAttributedString(string: model.isDefault ? "Default" : "", attributes: [
            .font : UIFont.systemFont(ofSize: 12, weight: .medium),
            .foregroundColor : UIColor.init(named: "card-text-isdefault")!
            ]
        )
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(direction: .vertical, spacing: 5, justifyContent: .start, alignItems: .start, children: [vehicle, vehicleDetails1, vehicleDetails2, isDefault])
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20, left: 20, bottom: .infinity, right: 0), child: stack)
    }
}
