//
//  ReusableConsultPopUpViewController.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 06/11/21.
//

import UIKit
import AsyncDisplayKit

class ReusableConsultPopUpViewController: ASDKViewController<ASDisplayNode> {
    
    let centreNode: ContentConsultPopupNode
    
    // MARK: - Initializer
    init(state: ReusableConsultPopUpState) {
        centreNode = ContentConsultPopupNode(state: state, secondTimeout: 1500)
        
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        
        node.layoutSpecBlock = { [weak self] _, _ in
            guard let self = self else { return ASLayoutSpec() }
            
            let inset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: .infinity, left: 18, bottom: .infinity, right: 18), child: self.centreNode)
            
            return ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: inset)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Viewcontroller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct InfoVCPreview: PreviewProvider {
    static var previews: some View {
        ReusableConsultPopUpViewController(state: .request).toPreview()
    }
}
#endif
