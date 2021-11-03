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
        vehicle.attributedText = .font(
            "\(model.manufacture) \(model.name)",
            size: 20, fontWeight: .bold
        )

        vehicleDetails1.attributedText = .font(
            "\(model.manufacturedYear) | \(model.transmissionType) | \(model.capacity) CC",
            size: 12
        )

        vehicleDetails2.attributedText = .font(
            "\(model.fuelType) | \(model.licensePlate)",
            size: 12
        )

        isDefault.attributedText = .font(
            model.isDefault ? "Default" : "",
            size: 12,
            fontWeight: .medium,
            color: UIColor.cardTextDefault
        )

        super.init()
        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 5,
            justifyContent: .start,
            alignItems: .start,
            children: [vehicle, vehicleDetails1, vehicleDetails2, isDefault]
        )

        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20, left: 20, bottom: .infinity, right: 0), child: stack)
    }
}
