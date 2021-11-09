import UIKit
import AsyncDisplayKit


class ExampleViewController: ASDKViewController<ASDisplayNode> {

    override init() {
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        node.backgroundColor = .white
        let selectNode = SelectFieldStack(title: "Manufacturer", placeholder: "Choose your vehicle manufacturer")
        node.layoutSpecBlock = { _, _ in
            ASInsetLayoutSpec(insets: UIEdgeInsets(top: .infinity, left: 16, bottom: .infinity, right: 16), child: selectNode)

        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

