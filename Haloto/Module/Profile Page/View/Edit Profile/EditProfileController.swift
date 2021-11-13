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
    // MARK: - Components

    private let chevronDown: ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage.chevronDown
        node.style.preferredSize = CGSize(width: 36, height: 16)
        node.contentMode = .scaleAspectFit
        return node
    }()

    private let editProfilePirctureNode: EditProfilePictureNode
    private let nameTextField: TextFieldNode
    private let emailTextField: TextFieldNode
    private let phoneTextField: TextFieldNode
    private var saveButton: SmallButtonNode?

    // MARK: - Variables

    private var imagePicker: ImagePickerHelper!
    private var profile: Profile

    init(profile: Profile) {
        self.profile = profile

        editProfilePirctureNode = EditProfilePictureNode(profilePictureData: profile.profilePicture)
        nameTextField = TextFieldNode(title: "Name", placeholder: "Ex. Martin Martini", state: .Editable)
        emailTextField = TextFieldNode(title: "Email", placeholder: "\(profile.profileEmail ?? "")", state: .notEditable)
        phoneTextField = TextFieldNode(title: "Phone", placeholder: "Ex. 0812345678", state: .Editable)

        super.init(node: ASDisplayNode())
        editProfilePirctureNode.delegate = self
        node.automaticallyManagesSubnodes = true

        saveButton = SmallButtonNode(title: "Save") {
            print("saveButtonAction")
            let newName = self.nameTextField.getText()
            let newPhoneNumber = self.phoneTextField.getText()
            let newImage = self.editProfilePirctureNode.getImageData()
            if let newName = newName, let newPhoneNumber = newPhoneNumber {
                let newProfile = Profile(
                    profilePicture: newImage,
                    profileName: newName,
                    profileEmail: self.profile.profileEmail,
                    profilePhone: newPhoneNumber,
                    authorizationToken: ""
                )

                print(newProfile)
                // TODO: Save new profile
                self.dismiss(animated: true, completion: nil)
            }
        }

        chevronDown.view.onTap {
            self.dismiss(animated: true, completion: nil)
        }

        node.layoutSpecBlock = { _, _ in
            let stack = ASStackLayoutSpec(direction: .vertical, spacing: 16, justifyContent: .center, alignItems: .center, children: [self.chevronDown, self.editProfilePirctureNode, self.nameTextField, self.emailTextField, self.phoneTextField, self.saveButton!])
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: .topSafeArea, left: 16, bottom: .bottomSafeArea, right: 16), child: stack)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        navigationController?.navigationBar.isHidden = true
        node.backgroundColor = .white
    }
}

extension EditProfileContoller: EditProfilePictureNodeDelegate, ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        if let image = image {
            editProfilePirctureNode.changeImage(image)
        }
    }

    func editProfilePictureAction() {
        print("editProfilePirctureAction")
        imagePicker = ImagePickerHelper(presentationController: self, delegate: self)
        imagePicker.present(from: editProfilePirctureNode.view)
    }
}
