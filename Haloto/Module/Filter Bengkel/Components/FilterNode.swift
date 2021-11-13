//
//  FilterNode.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/11/21.
//

import AsyncDisplayKit
import UIKit

class FilterNode: ASDisplayNode {
    // MARK: - Components

    private var separator: ASDisplayNode = {
        let node = ASDisplayNode()
        node.backgroundColor = .greyApp
        node.style.height = ASDimensionMakeWithPoints(0.5)
        return node
    }()

    private var activeFilter: ASTextNode2?

    private var chevron: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(width: 25, height: 25)
        node.image = .chevronDownKotak
        return node
    }()

    private let titleNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.style.flexGrow = 1
        return node
    }()

    private var filterTable: ASTableNode = {
        let node = ASTableNode()
        return node
    }()

    private var isOpen = false

    // MARK: - Privates

    private var filterData: [String]
    private var selectedData: [String]? = []
    private var type: FilterType

    init(type: FilterType, filterData: [String]) {
        self.filterData = filterData
        self.type = type

        switch type {
        case .model, .manufacturer:
            titleNode.attributedText = .font(type.rawValue, size: 18, fontWeight: .bold)
            filterTable.allowsMultipleSelection = true
        case .component:
            titleNode.attributedText = .font(type.rawValue, size: 18, fontWeight: .bold)
            filterTable.allowsMultipleSelection = true
        }
        super.init()
        automaticallyManagesSubnodes = true
        setupTable()
        chevron.view.onTap {
            [weak self] in
                guard let self = self else { return }
                self.isOpen = !self.isOpen
                self.changeChevron(isOpen: self.isOpen)
                self.setNeedsLayout()
        }
    }

    func changeChevron(isOpen: Bool) {
        if isOpen {
            chevron.image = .chevronUpKotak
        } else {
            chevron.image = .chevronDownKotak
        }
    }

    private func setupTable() {
        filterTable.dataSource = self
        filterTable.delegate = self
        filterTable.style.height = ASDimension(unit: .points, value: CGFloat(filterData.count * 40))
        filterTable.style.width = ASDimension(unit: .fraction, value: 1)
        filterTable.style.flexShrink = 1
        filterTable.backgroundColor = .blue
        filterTable.view.isScrollEnabled = false
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        if selectedData?.count ?? 0 > 0 {
            activeFilter = ASTextNode2()
            activeFilter?.attributedText = .font("\(selectedData?.count ?? 0) Active Filter", size: 12, color: .secondaryGreyApp)
        } else {
            activeFilter = nil
        }

        let titleStack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 12,
            justifyContent: .spaceBetween,
            alignItems: .center,
            children: [titleNode, activeFilter, chevron].compactMap { $0 }
        )
        titleStack.style.width = ASDimension(unit: .fraction, value: 1)

        let titleWithSeparator = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 12,
            justifyContent: .start,
            alignItems: .start,
            children: [titleStack, separator]
        )
        titleWithSeparator.style.width = ASDimension(unit: .fraction, value: 1)

        if !isOpen {
            return ASWrapperLayoutSpec(layoutElement: titleWithSeparator)
        }

        let stack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 8,
            justifyContent: .start,
            alignItems: .start,
            children: [titleStack, filterTable]
        )
        stack.style.width = ASDimension(unit: .fraction, value: 1)
        return stack
    }
}

extension FilterNode: ASTableDataSource, ASTableDelegate {
    func tableNode(_: ASTableNode, numberOfRowsInSection _: Int) -> Int {
        return filterData.count
    }

    func tableNode(_: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        return CellContentListPopUpNode(model: filterData[indexPath.row])
    }

    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        switch type {
        case .manufacturer, .model: if let cell = tableNode.indexPathsForSelectedRows {
                selectedData = []
                let selectedCell = cell.map { tableNode.cellForRow(at: $0) }
                _ = selectedCell.map { $0?.isSelected = false }
            }
        default: break
        }
        selectedData?.append(filterData[indexPath.row])
        tableNode.cellForRow(at: indexPath)?.isSelected = true
        setNeedsLayout()
    }

    func tableNode(_: ASTableNode, didDeselectRowAt indexPath: IndexPath) {
        let element = filterData[indexPath.row]
        if let index = selectedData?.firstIndex(of: element) {
            selectedData?.remove(at: index)
        }
        setNeedsLayout()
    }
}
