//
//  ExampleViewController.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 26/10/21.
//

import UIKit
import AsyncDisplayKit

class ExampleViewController: ASDKViewController<ASDisplayNode> {
    
    // MARK: - Initializer (Required)
    
    override init() {
        super.init(node: ASDisplayNode())
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
