//
//  MaintenanceDetailsViewController.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 09/11/21.
//

import AsyncDisplayKit
import RxSwift

class MaintenanceDetailsViewController: ASDKViewController<ASDisplayNode> {
    let headerNode = PaymentReviewHeader(title: "Maintenance Details")
    let updateHistoryNode: UpdateHistoryNode
    let scrollNode: ScrollNode
    let viewModel: MaintenanceDetailsViewModel
    let disposeBag: DisposeBag = DisposeBag()
    
    var servicedModel: [MaintenanceHistory] = []
    var replacedModel: [MaintenanceHistory] = []
    var otherModel: [OtherComponents] = []
    
    init(viewModel: MaintenanceDetailsViewModel) {
        self.viewModel = viewModel
        scrollNode = ScrollNode()
        updateHistoryNode = UpdateHistoryNode()
        scrollNode.style.flexShrink = 1

        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        node.layoutSpecBlock = { _, _ in

            let headerInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: self.headerNode)

            let scrollNodeInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: .topSafeArea + 48 + 12, left: 0, bottom: .bottomSafeArea + 76, right: 0), child: self.scrollNode)

            let updateHistoryInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: .bottomSafeArea, right: 0), child: self.updateHistoryNode)
            
            let headerBottomStack = ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .spaceBetween, alignItems: .start, children: [headerInset, updateHistoryInset])

            return ASOverlayLayoutSpec(child: scrollNodeInset, overlay: headerBottomStack)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        node.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
    }
    
    func registerObserver() {
//        viewModel.serviced.asObservable().flatMapLatest().subscribe { servicedModel in
//            self.servicedModel = servicedModel
//            self.scrollNode.servicedTableNode.servicedTable.reloadData()
//        }.disposed(by: disposeBag)
//        viewModel.serviced.bind(to: self.servicedModel).disposed(by: disposeBag)
//        
//        viewModel.replaced.asObservable().subscribe { replacedModel in
//            self.replacedModel = replacedModel
//            self.scrollNode.replacedTableNode.replacedTable.reloadData()
//        }.disposed(by: disposeBag)
//        
//        viewModel.other.asObservable().subscribe { otherModel in
//            self.otherModel = otherModel
//            self.scrollNode.otherTable.otherTableNode.reloadData()
//        }.disposed(by: disposeBag)
    }
}

extension MaintenanceDetailsViewController: ASTableDelegate, ASTableDataSource{
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        if tableNode == self.scrollNode.servicedTableNode.servicedTable{
            print("serviced tapped")
        }else if tableNode == self.scrollNode.replacedTableNode.replacedTable{
            print("replaced tapped")
        }else if tableNode == self.scrollNode.otherTable.otherTableNode{
            print("other tapped")
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        if tableNode == self.scrollNode.servicedTableNode.servicedTable{
            servicedModel.count
        }else if tableNode == self.scrollNode.replacedTableNode.replacedTable{
            replacedModel.count
        }else if tableNode == self.scrollNode.otherTable.otherTableNode{
            otherModel.count
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        return ASCellNode()
    }
}
