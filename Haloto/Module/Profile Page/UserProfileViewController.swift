//
//  UserProfileViewController.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/4/21.
//

import Foundation
import AsyncDisplayKit

class UserProfileViewController: ASDKViewController<ASDisplayNode> {
    
    // MARK: - Initializer (Required)
    override init() {
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        node.layoutSpecBlock = { _, _ in
            return ASLayoutSpec()
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
