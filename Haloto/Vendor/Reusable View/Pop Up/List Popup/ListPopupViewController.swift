//
//  SearchListPopupViewController.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 02/11/21.
//

import UIKit
import AsyncDisplayKit

internal class ListPopupViewController: ASDKViewController<ASDisplayNode> {
    // MARK: - Variable
    
    private let headerNode: HeaderListPopUpNode
    private var collectionNode: ASCollectionNode?
    private var searchNode: ASEditableTextNode?
    private let tableNode: ASTableNode = {
        let node = ASTableNode()
        return node
    }()
    
    var manufacturer: [Manufacturer]?
    var model: [Model]?
    var component: [ComponentList]?
    
    private var componentsSelected: [ComponentList] = []
    
    private var state: PopUpListState

    // MARK: - Initializer
    init(state: PopUpListState) {
        
        headerNode = HeaderListPopUpNode(state: state)
        self.state = state

        super.init(node: ASDisplayNode())
        
        node.automaticallyManagesSubnodes = true
        node.automaticallyRelayoutOnSafeAreaChanges = true
        
        setupNode()
        setupTableFunction()
        
        tableNode.style.flexGrow = 1
        
        node.layoutSpecBlock = { [weak self] _, _ in
            guard let self = self else { return ASLayoutSpec() }

            let topStack = ASStackLayoutSpec(
                direction: .vertical,
                spacing: 4,
                justifyContent: .spaceBetween,
                alignItems: .stretch,
                children: [self.headerNode, self.searchNode, self.collectionNode, self.tableNode].compactMap { $0 }
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
    
    private func setupNode() {
        headerNode.delegate = self
        
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
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.minimumLineSpacing = 1
            flowLayout.minimumInteritemSpacing = 1
            flowLayout.scrollDirection = .horizontal
            
            collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
            
            collectionNode?.delegate = self
            collectionNode?.dataSource = self
            collectionNode?.showsHorizontalScrollIndicator = false
            collectionNode?.view.allowsSelection = false
            collectionNode?.view.backgroundColor = .clear
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
    
    private func updateCollectionView() {
        collectionNode?.reloadData()
        
        if componentsSelected.count > 0 {
            collectionNode?.style.height = ASDimension(unit: .points, value: 46)
            collectionNode?.setNeedsLayout()
        } else {
            collectionNode?.style.height = ASDimension(unit: .points, value: 0)
            collectionNode?.setNeedsLayout()
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
            return CellContentListPopUpNode(model: data)
        case .service:
            let data = component?[indexPath.row].componentListName ?? ""
            return CellContentListPopUpNode(model: data)
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        switch state {
        case .service, .replaced:
            // Adding to object of array component selected & reload collection
            if let componentSelected = component?[indexPath.row] {
                componentsSelected.append(componentSelected)
                updateCollectionView()
            }
        default:
            break
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, didDeselectRowAt indexPath: IndexPath) {
        switch state {
        case .service, .replaced:
            if let component = self.component?[indexPath.row] {
                didTapDelete(model: component)
            }
        default:
            break
        }
    }
}

// MARK: - Extension for Collection View DataSource & Collection View Delegate

extension ListPopupViewController: ASCollectionDelegate, ASCollectionDataSource {
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        componentsSelected.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        let component = componentsSelected[indexPath.row]
        let filterNode = FilterMaintenanceCell(model: component)
        filterNode.delegateButtonFilter = self
        return filterNode
    }
}

// MARK: - Extension for ButtonDeleteFilterDelegate

extension ListPopupViewController: ButtonDeleteFilterDelegate {
    func didTapDelete(model: ComponentList) {
        componentsSelected = componentsSelected.filter({ $0.componentID != model.componentID })
        
        if let cellRow = component?.firstIndex(where: { $0.componentID == model.componentID }) {
            tableNode.cellForRow(at: IndexPath(row: cellRow, section: 0))?.isSelected = false
        }
        
        updateCollectionView()
    }
}

// MARK: - Extension for HeaderListPopUpNodeDelegate

extension ListPopupViewController: HeaderListPopUpNodeDelegate {
    func didTapRight() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didTapLeft() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
