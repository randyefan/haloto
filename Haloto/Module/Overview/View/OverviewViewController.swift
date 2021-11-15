//
//  OverviewViewController.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 05/11/21.
//

import AsyncDisplayKit
import UIKit
import RxSwift
import RxCocoa

class OverviewViewController: ASDKViewController<ASScrollNode> {
    // MARK: - Variable Node
    let vehicleNode: VehicleSection = {
        let node = VehicleSection()
        return node
    }()
    
    var upcomingMaintenanceNode: UpcomingMaintenanceSection?
    var maintenanceHistoryNode: MaintenanceHistorySection?
    
    // MARK: - Variable Model
    var modelUpcoming: [UpcomingMaintenance]?
    var modelMaintenanceHistory: [MaintenanceHistory]?
    var modelVehicle: [Vehicle]?
    
    // MARK: - Variable Trigger
    var viewDidLoadTriggered = PublishSubject<Void>()
    
    // MARK: - View Model
    let viewModel = OverviewViewModel()
    
    // MARK: - Initializer (Required)
    override init() {
        super.init(node: ASScrollNode())
        node.automaticallyManagesSubnodes = true
        node.automaticallyManagesContentSize = true
        node.layoutSpecBlock = { _, _ in
            if let modelVehicle = self.modelVehicle {
                self.vehicleNode.modelVehicle = modelVehicle
                self.vehicleNode.setNeedsLayout()
            }
            
            if let modelUpcoming = self.modelUpcoming {
                self.upcomingMaintenanceNode = UpcomingMaintenanceSection(model: modelUpcoming)
            }
            
            if let modelMaintenanceHistory = self.modelMaintenanceHistory {
                self.maintenanceHistoryNode = MaintenanceHistorySection(model: modelMaintenanceHistory)
            }
            
            let stack =  ASStackLayoutSpec(
                direction: .vertical,
                spacing: 10,
                justifyContent: .start,
                alignItems: .stretch,
                children: [self.vehicleNode, self.upcomingMaintenanceNode, self.maintenanceHistoryNode].compactMap({ $0 }))
            
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: .topSafeArea, left: 0, bottom: 70, right: 0), child: stack)
        }
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        node.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        navigationController?.isNavigationBarHidden = true
        
        registerObserver()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.viewDidLoadTriggered.onNext(())
    }
    
    // MARK: - Bind Functionality
    func bindViewModel() {
        // Define triggered
        let newTriggered = viewDidLoadTriggered.asDriver(onErrorJustReturn: ())
        
        // Declare Input-Output
        let input = OverviewViewModel.Input(viewDidLoad: newTriggered)
        let output = viewModel.transform(input: input)
        
        // Observe output
        output.listOfPersonalVehicle.drive(onNext: { [weak self] vehicleListResponse in
            guard let self = self else { return }
            if vehicleListResponse.status != 1 {
                self.showToast(title: vehicleListResponse.message ?? "")
                return
            }
            
            self.viewModel.modelManufacture(responseModel: vehicleListResponse.response ?? [])
        }).disposed(by: rx.disposeBag)
    }
    
    func registerObserver() {
        viewModel.vehicleList.subscribe(onNext: { [weak self] listVehicle in
            guard let self = self else { return }
            self.modelVehicle = listVehicle
            self.node.setNeedsLayout()
        }).disposed(by: rx.disposeBag)
    }
}
