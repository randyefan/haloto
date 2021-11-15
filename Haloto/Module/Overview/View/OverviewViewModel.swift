//
//  OverviewViewModel.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 13/11/21.
//

import RxSwift
import UIKit
import RxCocoa

class OverviewViewModel {
    public let vehicle: PublishSubject<[Vehicle]> = PublishSubject()
    public let upomingMaintenance: PublishSubject<[UpcomingMaintenance]> = PublishSubject()
    public let maintenanceHistory: PublishSubject<[MaintenanceHistory]> = PublishSubject()
    
    func requestDataVehicle(){
        
    }
    
    func requestDataUpcomingMaintenance(){
        
    }
    
    func requestDataMaintenanceHistory(){
        
    }
}
