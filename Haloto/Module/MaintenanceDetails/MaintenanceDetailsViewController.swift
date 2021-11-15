//
//  MaintenanceDetailsViewController.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 09/11/21.
//

import AsyncDisplayKit
import RxSwift
import CoreMedia

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
        viewModel.serviced.asObservable().subscribe(onNext: { maintenanceHistory in
            self.servicedModel = maintenanceHistory
        }).disposed(by: disposeBag)
        
        viewModel.replaced.asObservable().subscribe(onNext: { maintenanceHistory in
            self.servicedModel = maintenanceHistory
        }).disposed(by: disposeBag)
        
        viewModel.other.asObservable().subscribe(onNext: { maintenanceHistory in
            self.otherModel = maintenanceHistory
        }).disposed(by: disposeBag)
    }
}

extension MaintenanceDetailsViewController: ASTableDelegate, ASTableDataSource{
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        if tableNode == self.scrollNode.servicedTableNode.servicedTable{
            if indexPath.row == servicedModel.count{
                
            }
        }else if tableNode == self.scrollNode.replacedTableNode.replacedTable{
            print("replaced tapped")
        }else if tableNode == self.scrollNode.otherTable.otherTableNode{
            print("other tapped")
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        if tableNode == self.scrollNode.servicedTableNode.servicedTable{
            return servicedModel.count
        }else if tableNode == self.scrollNode.replacedTableNode.replacedTable{
            return replacedModel.count
        }else if tableNode == self.scrollNode.otherTable.otherTableNode{
            return otherModel.count
        }
        return 0
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        if tableNode == self.scrollNode.servicedTableNode.servicedTable{
            if indexPath.row == servicedModel.count{
                return WrapperSelectNode(placeHolder: "Choose what part you serviced")
            } else {
                let data = servicedModel[indexPath.row]
//                return SelectedComponentCell(model: data)
            }
        }
        return ASCellNode()
    }
}
