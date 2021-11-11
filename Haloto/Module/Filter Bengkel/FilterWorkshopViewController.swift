//
//  FilterWorkshopViewController.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/11/21.
//

import AsyncDisplayKit
import UIKit

class FilterWorkshopViewController: ASDKViewController<ASDisplayNode> {
    
    override init(){
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        
        let chevronDown = ASImageNode()
        chevronDown.image = .chevronDown
        chevronDown.style.preferredSize = CGSize(width: 48, height: 24)
        
        let locationSearchBar = TextFieldNode(title: nil, placeholder: "Location", state: .Editable)
        let filterManufacterNode = FilterNode(type: .manufacturer, filterData: ["Daihatsu", "Toyota", "Suzuki", "Yamaha", "asdasd"])
        let filterModelNode = FilterNode(type: .model, filterData: ["Brio", "E36", "E47", "700I", "Jokowi"])
        let filterComponentNode = FilterNode(type: .component, filterData: ["Filter", "Oli", "Aki", "Mesin", "Per", "Ban", "Velg", "Knalpot", "Knalpot1", "Knalpot2", "Knalpot3"])
        
        let scrollView = ASScrollNode()
        
        let clearFilterButton = SmallButtonNode(title: "Clear Filter", buttonState: .GreyButton) {
            //TODO: Clear Filter Action
            print("Clear Filter Action")
        }
        clearFilterButton.style.width = ASDimensionMakeWithFraction(0.4)
        
        let applyButton = SmallButtonNode(title: "Apply Filter", buttonState: .Yellow) {
            //TODO: Apply Action
            print("Apply Filter")
        }
        applyButton.style.width = ASDimensionMakeWithFraction(0.4)
        
        scrollView.layoutSpecBlock = {_,_ in
            
            
            return ASStackLayoutSpec(
                direction: .vertical,
                spacing: 12,
                justifyContent: .start,
                alignItems: .start,
                children: [filterManufacterNode,filterModelNode,filterComponentNode]
            )
            
        }
        
        scrollView.automaticallyManagesContentSize = true
        scrollView.automaticallyManagesSubnodes = true
        scrollView.style.flexShrink = 1
        
        node.layoutSpecBlock = { _,_ in
            
            let buttonStack = ASStackLayoutSpec(
                direction: .horizontal,
                spacing: 18,
                justifyContent: .center,
                alignItems: .center,
                children: [clearFilterButton, applyButton]
            )
            buttonStack.style.width = ASDimensionMakeWithFraction(1)
            
            
            let stack = ASStackLayoutSpec(
                direction: .vertical,
                spacing: 18,
                justifyContent: .start,
                alignItems: .center,
                children: [chevronDown, locationSearchBar, scrollView]
            )
            let overlayInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: .infinity, left: 0, bottom: .bottomSafeArea, right: 0), child: buttonStack)
            let pageInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: .topSafeArea, left: 16, bottom: .bottomSafeArea + 50, right: 16), child: stack)
            
            return ASOverlayLayoutSpec(child: pageInset, overlay: overlayInset)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Controller
    override func viewDidLoad() {
        navigationController?.navigationBar.isHidden = true
        node.backgroundColor = .white
    }
    
}
