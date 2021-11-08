//
//  WorkshopConsultationMainCell.swift
//  Haloto
//
//  Created by darindra.khadifa on 05/11/21.
//

import AsyncDisplayKit

internal final class WorkshopConsultationMainNode: ASDisplayNode {

    private let workshopDescriptionNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()

    private let specialtyTitleNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font("Specialty", size: 12, fontWeight: .bold)
        return node
    }()

    private let specialtyListNode: ASCollectionNode = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = 8

        let node = ASCollectionNode(collectionViewLayout: flowLayout)
        node.style.height = ASDimensionMake(55)
        return node
    }()

    private let availableHoursTitleNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font("Available Hours", size: 12, fontWeight: .bold)
        return node
    }()

    private let availableHours: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()

    private let workshopCardNode: WorkshopConsultationCard
    private let consultButon = SmallButtonNode(title: "Consult Now", buttonState: .Yellow, function: nil)

    private var isOpen: Bool = false

    override init() {
        workshopCardNode = WorkshopConsultationCard()
        workshopCardNode.style.width = ASDimensionMakeWithFraction(1)

        super.init()
        automaticallyManagesSubnodes = true
        specialtyListNode.delegate = self
        specialtyListNode.dataSource = self

        availableHours.attributedText = .font("10 am - 7 pm", size: 12)
        workshopDescriptionNode.attributedText = .font(
            "“Fixing vehicles since 1998, we fix a variety of brands and is expert at handling engines.”",
            size: 12
        )

        setShadow()


    }

    override func layout() {
        super.layout()
        cornerRadius = 15
        backgroundColor = .white
        specialtyListNode.view.showsHorizontalScrollIndicator = false

        let gesture = UITapGestureRecognizer(target: self, action: #selector(setOpen))
        view.addGestureRecognizer(gesture)
    }

    @objc private func setOpen() {
        isOpen = !isOpen
        setNeedsLayout()
    }

    func setShadow() {
        shadowColor = UIColor.black.cgColor
        shadowOpacity = 0.12
        shadowOffset.height = 2
        shadowRadius = 4
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        if !isOpen {
            return ASWrapperLayoutSpec(layoutElement: workshopCardNode)
        }

        let specialtyStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 8,
            justifyContent: .start,
            alignItems: .stretch,
            children: [specialtyTitleNode, specialtyListNode]
        )

        let availableHoursStack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 0,
            justifyContent: .spaceBetween,
            alignItems: .stretch,
            children: [availableHoursTitleNode, availableHours]
        )

        let buttonInset = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 0, left: 103, bottom: 0, right: 103), child: consultButon)

        let openStateStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 16,
            justifyContent: .start,
            alignItems: .stretch,
            children: [workshopDescriptionNode, specialtyStack, availableHoursStack, buttonInset]
        )

        let openInset = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 0, left: 16, bottom: 12, right: 16),
            child: openStateStack)

        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 12,
            justifyContent: .start,
            alignItems: .start,
            children: [workshopCardNode, openInset]
        )
    }
}

extension WorkshopConsultationMainNode: ASCollectionDelegate, ASCollectionDataSource {
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        10
    }

    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        ChipCellNode("engine")
    }
}
