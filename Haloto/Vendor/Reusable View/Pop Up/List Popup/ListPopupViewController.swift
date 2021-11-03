//
//  SearchListPopupViewController.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 02/11/21.
//

import UIKit
import AsyncDisplayKit

enum PopUpListState: String {
    case model = "Model"
    case manufacturer = "Manufacturer"
    case service = "Service"
    case replaced = "Replaced"
}

internal class ListPopupViewController: ASDKViewController<ASDisplayNode> {
    // MARK: - Variable
    private let headerNode: HeaderListPopUpNode
    private var searchNode: ASEditableTextNode?
    private let tableNode: ASTableNode = {
        let node = ASTableNode()
        return node
    }()

    // MARK: - Initializer
    init(state: PopUpListState) {
        headerNode = HeaderListPopUpNode(state: state)

        super.init(node: ASDisplayNode())
        setupSearchNode(state: state)
        node.automaticallyManagesSubnodes = true
        node.layoutSpecBlock = { [weak self] _, _ in
            guard let self = self else { return ASLayoutSpec() }

            let topStack = ASStackLayoutSpec(
                direction: .vertical,
                spacing: 16,
                justifyContent: .start,
                alignItems: .stretch,
                children: [self.headerNode, self.searchNode, self.tableNode].compactMap { $0 }
            )

            return ASInsetLayoutSpec(
                insets: UIEdgeInsets(top: .infinity, left: 12, bottom: 0, right: 12),
                child: topStack)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.node.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
    }

    private func setupSearchNode(state: PopUpListState) {
        switch state {
        case .model, .manufacturer:
            searchNode = ASEditableTextNode()
            searchNode?.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            searchNode?.borderColor = UIColor.greyApp.cgColor
            searchNode?.borderWidth = 1
            searchNode?.cornerRadius = 3
            searchNode?.attributedPlaceholderText = .font("Search",
                size: 12,
                color: .gray,
                alignment: .left,
                isTitle: false)
        default:
            searchNode = nil
        }
    }
}
