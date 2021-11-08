//
//  ExampleViewController.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 26/10/21.
//

import UIKit
import AsyncDisplayKit

class dataDummy {
   
        var vehicle = Vehicle(
            name: "BRIO",
            fuelType: "Petrol",
            manufacture: "HONDA",
            manufacturedYear: "2015",
            capacity: 1100,
            transmissionType: "Automatic",
            licensePlate: "A 1232 RE",
            isDefault: true
        )
    
        var profile = Profile(profilePicture: "profile-image-placeholder",
                              profileName: "Bowo Santoso",
                              profileEmail: "bowo@santosocompany.com",
                              profilePhone: "087774584922",
                              authorizationToken: ""
        )
}

class ExampleViewController: ASDKViewController<ASDisplayNode> {
    // MARK: - Initializer (Required)
    
    override init() {
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        let kuning = SmallButtonNode(title: "Testing", buttonState: .Yellow) {
            print("kuning")
        }
        let biru = SmallButtonNode(title: "Testing", buttonState: .Blue) {
            print("biru")
        }
        let outline = SmallButtonNode(title: "Testing", buttonState: .BlueOutlined) {
            print("outline")
        }
        let disable = SmallButtonNode(title: "Testing", buttonState: .notSelectable) {
            print("disable")
        }
        
        let vehicleCell = VehicleCellNode(model: dataDummy().vehicle)
        let c = AddNewVehicleCellNode()
        let d = ProfileInfoNode(profile: dataDummy().profile)
        let e = ProfileBackgroundCard()
        //let f = ProfileFinalNode(profile: profile, delegate: self)
        let g = TextFieldNode(title: "Name", placeholder: "Ex. Martin Gratianus", state: .Editable)
        let f = TextFieldNode(title: "Email", placeholder: "martin.aisdoa@nasdi.com", state: .notEditable)
        g.delegate = self
        let profile = EditProfilePictureNode(profilePictureUrl: "")

        node.layoutSpecBlock = { _,_ in
            let stack = ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .center, alignItems: .center, children: [kuning,biru, outline, disable])
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 100, left: .infinity, bottom: .infinity, right: .infinity),
                                     child: c)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        node.backgroundColor = .white
    }
}

extension ExampleViewController: TextFieldNodeDelegate {
    func didEndEdit(text: String) {
        print(text)
    }
    
    @objc func didTapEdit() {
        print("edit tapped")
    }
}
