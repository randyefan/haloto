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
    
    var manufacturer: [Manufacturer]?
    var model: [Model]?
    var component: [ComponentList]?
    
    var state: PopUpListState

    // MARK: - Initializer
    init(state: PopUpListState) {
        
        headerNode = HeaderListPopUpNode(state: state)
        self.state = state

        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        node.automaticallyRelayoutOnSafeAreaChanges = true
        
        setupSearchNode()
        setupTableFunction()
        
        tableNode.style.flexGrow = 1
        
        node.layoutSpecBlock = { [weak self] _, _ in
            guard let self = self else { return ASLayoutSpec() }

            let topStack = ASStackLayoutSpec(
                direction: .vertical,
                spacing: 16,
                justifyContent: .spaceBetween,
                alignItems: .stretch,
                children: [self.headerNode, self.searchNode, self.tableNode].compactMap { $0 }
            )
            
            return ASInsetLayoutSpec(
                insets: UIEdgeInsets(top: .topSafeArea, left: 12, bottom: 0, right: 12),
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

    // MARK: - Functionality
    
    private func setupSearchNode() {
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
    
    private func setupTableFunction() {
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.view.showsVerticalScrollIndicator = false
        
        switch state {
        case .manufacturer, .model:
            tableNode.allowsMultipleSelection = false
        case .replaced, .service:
            tableNode.allowsMultipleSelection = true
        }
    }
}

// MARK: - Extension for Table Data Source & Delegate

extension ListPopupViewController: ASTableDataSource, ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .replaced:
            guard let component = component else { return 0 }
            return component.count
        case .manufacturer:
            guard let manufacturer = manufacturer else { return 0 }
            return manufacturer.count
        case .model:
            guard let model = model else { return 0 }
            return model.count
        case .service:
            guard let component = component else { return 0 }
            return component.count
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        switch state {
        case .replaced:
            let data = component?[indexPath.row].componentListName ?? ""
            return CellContentListPopUpNode(model: data)
        case .manufacturer:
            let data = manufacturer?[indexPath.row].name ?? ""
            return CellContentListPopUpNode(model: data)
        case .model:
            let data = model?[indexPath.row].name ?? ""
            return CellSelectedListPopUpNode(title: data)
        case .service:
            let data = component?[indexPath.row].componentListName ?? ""
            return CellContentListPopUpNode(model: data)
        }
    }
}
