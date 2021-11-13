//
//  MaintenanceDetailsViewModel.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 13/11/21.
//

import RxSwift
import UIKit
import RxCocoa

class MaintenanceDetailsViewModel {
    public let serviced: PublishSubject<[MaintenanceHistory]> = PublishSubject()
    public let replaced: PublishSubject<[MaintenanceHistory]> = PublishSubject()
    public let other: PublishSubject<[OtherComponents]> = PublishSubject()
    
}
