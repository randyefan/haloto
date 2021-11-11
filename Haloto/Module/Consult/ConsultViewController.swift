//
//  ConsultViewController.swift
//  Haloto
//
//  Created by darindra.khadifa on 05/11/21.
//

import AsyncDisplayKit


internal final class ConsultViewController: ASDKViewController<ASDisplayNode> {
    private let collectionNode: ASCollectionNode = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0

        let node = ASCollectionNode(collectionViewLayout: flowLayout)
        node.style.flexGrow = 1
        return node
    }()

    private let headerNode = ConsultViewHeader()


    override init() {
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        node.layoutSpecBlock = { [weak self] _, _ in
            guard let self = self else { return ASLayoutSpec() }

            return ASStackLayoutSpec(
                direction: .vertical,
                spacing: 8,
                justifyContent: .start,
                alignItems: .stretch,
                children: [self.headerNode, self.collectionNode]
            )
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        node.backgroundColor = .white
        collectionNode.delegate = self
        collectionNode.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.showTabBar()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func navigateToPaymentDetail() {
        let vc = UserPaymentReviewViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ConsultViewController: ASCollectionDataSource, ASCollectionDelegate {
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        10
    }

    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        let cell = WorkshopConsultationMainCell()
        cell.delegate = self
        return cell
    }
}

extension ConsultViewController: WorkshopConsultationMainNodeDelegate {
    func didTapConsultNow() {
        navigateToPaymentDetail()
    }
}
