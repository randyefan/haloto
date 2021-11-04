//
//  ExampleViewController.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 26/10/21.
//

import UIKit
import AsyncDisplayKit

class ExampleViewController: ASDKViewController<ASDisplayNode> {
    
    let vehicle = Vehicle(
        name: "BRIO",
        fuelType: "Petrol",
        manufacture: "HONDA",
        manufacturedYear: "2015",
        capacity: 1100,
        transmissionType: "Automatic",
        licensePlate: "A 1232 RE",
        isDefault: true
    )
    
    let profile = Profile(profilePicture: "profile-image-placeholder",
                          profileName: "Bowo Santoso",
                          profileEmail: "bowo@santosocompany.com",
                          profilePhone: "087774584922",
                          authorizationToken: ""
    )
    
    // MARK: - Initializer (Required)
    
    override init() {
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        let vehicleCell = VehicleCellNode(model: vehicle)
        //let b = SmallYellowButtonNode(title: "asdasdasdasd")
        let c = AddNewVehicleCellNode()
        let d = ProfileInfoNode(profile: profile)
        let e = ProfileBackgroundCard()

        node.layoutSpecBlock = { _,_ in
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 50, left: 10, bottom: .infinity, right: 10),
                                     child: e)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        node.backgroundColor = .blue
    }
}

extension ExampleViewController: ProfileBackgroundCardDelegate{
    @objc func didTapEdit() {
        print("edit tapped")
    }
    
    
}
