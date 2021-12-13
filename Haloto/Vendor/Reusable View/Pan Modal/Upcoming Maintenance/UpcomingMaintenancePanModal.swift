//
//  UpcomingMaintenancePanModal.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/9/21.
//

import AsyncDisplayKit

class UpcomingMaintenancePanModal: ASDKViewController<ASDisplayNode> {
    // MARK: - Components

    private let chevronDown: ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage.chevronDown
        node.style.preferredSize = CGSize(width: 36, height: 16)
        node.contentMode = .scaleAspectFit
        return node
    }()

    private let titleNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font(
            "Your Upcoming Maintenance",
            size: 18,
            fontWeight: .bold,
            alignment: .center,
            isTitle: true
        )
        return node
    }()

    private var componentTableNode: ASCollectionNode?
    private var addToHistoryButton: SmallButtonNode?
    private var deleteButton: SmallButtonNode?

    // MARK: - Private

    private var maintenance: UpcomingMaintenance
    private var components: [Component]?
    private var nilComponent = Component(
        name: "",
        componentImage: "",
        lastReplacementOdometer: 0,
        lastReplacementDate: "",
        lifetimeOdometer: 0,
        lifetimeDate: ""
    )

    // MARK: - Init (Required)

    init(maintenance: UpcomingMaintenance) {
        self.maintenance = maintenance

        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        node.automaticallyRelayoutOnSafeAreaChanges = true
        setAction()
        deleteButton?.style.width = ASDimension(unit: .fraction, value: 0.5)
        addToHistoryButton?.style.width = ASDimension(unit: .fraction, value: 0.5)
        setupCollectionView()

        node.layoutSpecBlock = { _, _ in
            let buttonStack = ASStackLayoutSpec(direction: .horizontal, spacing: 8, justifyContent: .center, alignItems: .center, children: [self.deleteButton, self.addToHistoryButton].compactMap { $0 })

            buttonStack.style.width = ASDimension(unit: .fraction, value: 1)

            let nodeStack = ASStackLayoutSpec(direction: .vertical, spacing: 16, justifyContent: .center, alignItems: .center, children: [self.titleNode, self.componentTableNode!, buttonStack].compactMap { $0 })

            nodeStack.style.width = ASDimension(unit: .fraction, value: 1)

            let withChevronStack = ASStackLayoutSpec(direction: .vertical, spacing: 32, justifyContent: .center, alignItems: .center, children: [self.chevronDown, nodeStack])

            let nodeInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: .topSafeArea, left: 16, bottom: .bottomSafeArea, right: 16), child: withChevronStack)
            return nodeInset
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functionality

    private func setAction() {
        chevronDown.view.onTap {
            self.dismiss(animated: true, completion: nil)
        }
        addToHistoryButton = SmallButtonNode(title: "Add to Hitory", buttonState: .Yellow, function: {
            // TODO: Add to history Action
            print("Add to history Action")
        })
        deleteButton = SmallButtonNode(title: "Delete reminder", buttonState: .GreyButton, function: {
            // TODO: Delete reminder Action
            print("Delete reminder Action")
        })
    }

    private func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        componentTableNode = ASCollectionNode(collectionViewLayout: flowLayout)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        componentTableNode?.allowsSelection = false
        componentTableNode?.dataSource = self
        let tableNodeHeight = 88.0 * Double(maintenance.components?.count ?? 0)
        componentTableNode?.style.height = ASDimension(unit: .points, value: tableNodeHeight)
        componentTableNode?.showsVerticalScrollIndicator = false
    }

    // MARK: - ViewController LifeCycle

    override func viewDidLoad() {
        node.backgroundColor = .white
    }
}

extension UpcomingMaintenancePanModal: ASCollectionDataSource {
    func collectionNode(_: ASCollectionNode, numberOfItemsInSection _: Int) -> Int {
        return maintenance.components?.count ?? 0
    }

    func collectionNode(_: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        return UpcomingMaintenanceComponentCell(component: maintenance.components?[indexPath.row] ?? nilComponent, date: maintenance.nextServiceDate ?? "")
    }
}
