//
//  ReusableConsultPopUpViewController.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 06/11/21.
//

import UIKit
import AsyncDisplayKit

class ReusableConsultPopUpViewController: ASDKViewController<ASDisplayNode> {
    
    let buttonXNode: ASImageNode = {
        let node = ASImageNode()
        node.style.width = ASDimension(unit: .points, value: 30)
        node.style.height = ASDimension(unit: .points, value: 30)
        node.image = UIImage(named: "x_icon")
        return node
    }()
    
    let centreNode: ContentConsultPopupNode
    
    // MARK: - Initializer
    init(state: ReusableConsultPopUpState) {
        centreNode = ContentConsultPopupNode(state: state, secondTimeout: 1500)
        
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        
        tapObserve()
        
        node.layoutSpecBlock = { [weak self] _, _ in
            guard let self = self else { return ASLayoutSpec() }
            
            let imageInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: .topSafeArea, left: 16, bottom: .infinity, right: .infinity),
                                               child: self.buttonXNode)
            
            let inset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: .infinity, left: 18, bottom: .infinity, right: 18), child: self.centreNode)
            
            let centreLayout = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: inset)
            
            return ASOverlayLayoutSpec(child: centreLayout, overlay: imageInset)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Viewcontroller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        node.backgroundColor = .white
    }
    
    // MARK: - Tap Observe
    
    func tapObserve() {
        buttonXNode.view.onTap {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

#if DEBUG
 import SwiftUI

 @available(iOS 13, *)
 struct InfoVCPreview: PreviewProvider {
     static var previews: some View {
         ReusableConsultPopUpViewController(state: .declined).toPreview()
     }
 }
 #endif
