import UIKit
import AsyncDisplayKit


class ExampleViewController: ASDKViewController<ASTableNode> {

    // MARK: - Initializer (Required)


    override init() {
        super.init(node: ASTableNode())
        node.backgroundColor = .white
        node.dataSource = self
        node.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        node.view.separatorStyle = .none
    }
}


extension ExampleViewController: ASTableDataSource, ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        WorkshopConsultationMainCell()
    }
}

