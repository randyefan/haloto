import UIKit
import AsyncDisplayKit


class ExampleViewController: ASDKViewController<ASDisplayNode> {

    // MARK: - Initializer (Required)


    override init() {
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        node.backgroundColor = .white

        let upcoming = UpcomingMaintenanceCell(model: sampleUpcomingMaintenance)
        let stickyChatNode = StickyChatNode()

        node.layoutSpecBlock = { _, _ in
            return ASInsetLayoutSpec(
                insets: UIEdgeInsets(top: .infinity, left: 0, bottom: 0, right: 0),
                child: stickyChatNode
            )
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        node.backgroundColor = .blueApp
    }
}

let sampleUpcomingMaintenance: UpcomingMaintenance =
    UpcomingMaintenance(components: [Component(name: "Accu",
    lastReplacementOdometer: 20000,
    lastReplacementDate: "1 Jan 2020",
    lifetimeOdometer: 0,
    lifetimeDate: "1 Jan 2019")],
    nextServiceOdometer: 40000,
    nextServiceDate: "1 Jan 2021")

