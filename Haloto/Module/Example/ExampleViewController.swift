//
//  ExampleViewController.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 26/10/21.
//

import UIKit
import AsyncDisplayKit

class ExampleViewController: ASDKViewController<ASDisplayNode> {

    var button: SmallYellowButtonNode!
    // MARK: - Initializer (Required)
    override init() {
        super.init(node: ASDisplayNode())

        button = SmallYellowButtonNode(title: "Hai Randy", target: self, function: #selector(test))

        node.automaticallyManagesSubnodes = true
        node.backgroundColor = .white

        node.layoutSpecBlock = { _, _ in
            return ASInsetLayoutSpec(
                insets: UIEdgeInsets(top: .infinity, left: .infinity, bottom: .infinity, right: .infinity),
                child: self.button
            )
        }
    }

    @objc func test() {
        let vc = ListPopupViewController(state: .model)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
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
