//
//  ConsultRatingNode.swift
//  Haloto
//
//  Created by darindra.khadifa on 08/11/21.
//

import AsyncDisplayKit
import UIKit

internal final class ConsultRatingNode: ASDisplayNode {

    private let ratingTitle: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font("Tell Us Your Experience", size: 18, fontWeight: .bold, alignment: .center)
        return node
    }()

    private let ratingDescription: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font("How Was Your Consultation ?", size: 12, alignment: .center)
        return node
    }()

    private let badRating: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font("Bad", size: 11, fontWeight: .medium, alignment: .center)
        node.style.width = ASDimensionMake(47)
        return node
    }()

    private let awesomeRating: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font("Awesome", size: 11, fontWeight: .medium)
        return node
    }()


    private let additionalCommentTitle: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font("Tell Us More About Your Experience", size: 12, alignment: .center)
        return node
    }()

    private lazy var additionalCommentInput: ViewWrapperNode<UITextView> = {
        let wrapperNode = ViewWrapperNode<UITextView>(createView: {
            let textView = UITextView()
            textView.text = "Input your comment here..."
            textView.font = UIFont(name: "Poppins-Regular", size: 12)
            textView.textColor = UIColor.lightGray
            textView.autocorrectionType = .no
            textView.autocapitalizationType = .sentences
            textView.returnKeyType = .done
            textView.delegate = self
            return textView
        })
        wrapperNode.wrappedView.textContainerInset = UIEdgeInsets(top: 12, left: 16, bottom: 16, right: 12)
        wrapperNode.borderColor = UIColor.greyApp.cgColor
        wrapperNode.shadowColor = UIColor.blackApp.cgColor
        wrapperNode.shadowOpacity = 0.12
        wrapperNode.shadowOffset.height = 0
        wrapperNode.shadowRadius = 4
        wrapperNode.borderWidth = 1
        wrapperNode.cornerRadius = 10
        wrapperNode.style.height = ASDimensionMake(132)
        return wrapperNode
    }()

    private var ratingStar = [StarNode]()
    private var rating = 0
    private var buttonState = ButtonState.Disabled
    private let workshopCardNode: WorkshopConsultationCard
    private var submitButton: SmallButtonNode

    override init() {
        workshopCardNode = WorkshopConsultationCard()
        submitButton = SmallButtonNode(title: "Submit", buttonState: buttonState, function: nil)

        super.init()
        automaticallyManagesSubnodes = true
        setShadow()
        setupRating()

    }

    private func setupRating() {
        ratingStar = (1...5).map({ [weak self] index in
            let node = index <= rating ? StarNode(.active) : StarNode(.inactive)
            node.rating = {
                self?.rating = index
                self?.buttonState = .Yellow
                self?.submitButton = SmallButtonNode(title: "Submit", buttonState: .Yellow, function: nil)
                self?.setupRating()
                self?.setNeedsLayout()
            }
            return node
        })
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let titleStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 2,
            justifyContent: .start,
            alignItems: .stretch,
            children: [ratingTitle, ratingDescription]
        )

        let starStack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 0,
            justifyContent: .spaceBetween,
            alignItems: .stretch,
            children: ratingStar
        )

        let starBottomStack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 0,
            justifyContent: .spaceBetween,
            alignItems: .stretch,
            children: [badRating, awesomeRating]
        )

        let starFinalStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 8,
            justifyContent: .start,
            alignItems: .stretch,
            children: [starStack, starBottomStack]
        )

        let buttonInset = ASInsetLayoutSpec(
            insets: .init(top: 0, left: 104, bottom: 0, right: 104),
            child: submitButton
        )

        let commentStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 8,
            justifyContent: .start,
            alignItems: .stretch,
            children: [additionalCommentTitle, additionalCommentInput]
        )

        let commentInset = ASInsetLayoutSpec(
            insets: .init(top: 16, left: 0, bottom: 0, right: 0),
            child: commentStack
        )

        let bottomStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 16,
            justifyContent: .center,
            alignItems: .stretch,
            children: [titleStack, starFinalStack, commentInset, buttonInset]
        )

        let bottomInset = ASInsetLayoutSpec(
            insets: .init(top: 0, left: 16, bottom: 18, right: 16),
            child: bottomStack
        )

        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 16,
            justifyContent: .center,
            alignItems: .stretch,
            children: [workshopCardNode, bottomInset]
        )
    }

    override func layout() {
        super.layout()
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }

    private func setShadow() {
        backgroundColor = .white
        cornerRadius = 15
        shadowColor = UIColor.black.cgColor
        shadowOpacity = 0.12
        shadowOffset.height = 2
        shadowRadius = 4
    }
}

extension ConsultRatingNode: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Input your comment here..."
            textView.textColor = UIColor.lightGray
        }
    }
}
