//
//  EditProfileController.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/5/21.
//

import AsyncDisplayKit
import CoreGraphics
import UIKit

class EditProfileContoller: ASDKViewController<ASDisplayNode> {
    init(profile: Profile) {
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        node.backgroundColor = .white

        let chevronDown: ASImageNode = {
            let node = ASImageNode()
            node.image = UIImage.chevronDown
            node.style.preferredSize = CGSize(width: 36, height: 16)
            node.contentMode = .scaleAspectFit
            return node
        }()
        let editProfilePirctureNode = EditProfilePictureNode(profilePictureUrl: profile.profilePicture ?? "")
        editProfilePirctureNode.delegate = self
        let nameTextField = TextFieldNode(title: "Name", placeholder: "Ex. Martin Martini", state: .Editable)
        let emailTextField = TextFieldNode(title: "Email", placeholder: "\(profile.profileEmail ?? "")", state: .notEditable)
        let phoneTextField = TextFieldNode(title: "Phone", placeholder: "Ex. 0812345678", state: .Editable)
        let saveButton = SmallButtonNode(title: "Save") {
            print("saveButtonAction")
        }

        chevronDown.view.onTap {
            print("chevronDownAction")
        }

        node.layoutSpecBlock = { _, _ in
            let stack = ASStackLayoutSpec(direction: .vertical, spacing: 16, justifyContent: .center, alignItems: .center, children: [chevronDown, editProfilePirctureNode, nameTextField, emailTextField, phoneTextField, saveButton])
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: .topSafeArea, left: 16, bottom: .bottomSafeArea, right: 16), child: stack)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EditProfileContoller: EditProfilePictureNodeDelegate {
    func editProfilePictureAction() {
        print("editProfilePirctureAction")
    }

    override func viewDidLoad() {
        navigationController?.navigationBar.isHidden = true
    }
}
