//
//  AddNewVehicleViewController.swift
//  Haloto
//
//  Created by Javier Fransiscus on 09/11/21.
//

import AsyncDisplayKit
import UIKit

class AddNewVehicleViewController: ASDKViewController<ASDisplayNode> {
    // MARK: - Components

    private lazy var manufacturerFormNode: SelectFieldStack = {
        let node = SelectFieldStack(title: "Manufacturer", placeholder: "Choose your vehicle manufacturer")
        return node
    }()

    private lazy var modelFormNode: SelectFieldStack = {
        let node = SelectFieldStack(title: "Model", placeholder: "Choose your vehicle model")
        return node
    }()

    private lazy var odometerFormNode: FormFieldStack = {
        let node = FormFieldStack(isPicker: false, title: "Odometer", placeholder: "Current Km", keyboardType: .numberPad)
        return node
    }()

    private lazy var licensePlateFormNode: FormFieldStack = {
        let node = FormFieldStack(isPicker: false, title: "License Plate", placeholder: "License Plate", keyboardType: .default)
        return node
    }()

    private lazy var manufacturedYearFormNode: FormFieldStack = {
        let node = FormFieldStack(isPicker: true, title: "Manufactured Year", text: "2018")
        return node
    }()

    private lazy var ccFormNode: FormFieldStack = {
        let node = FormFieldStack(isPicker: true, title: "CC", text: "1200")
        return node
    }()

    private lazy var tranmissionStack: ButtonFieldStack = {
        let node = ButtonFieldStack(title: "Transmission", firstButtonText: "Matic", secondButtonText: "Manual")
        return node
    }()

    private lazy var fuelTypeStack: ButtonFieldStack = {
        let node = ButtonFieldStack(title: "Fuel Type", firstButtonText: "Diesel", secondButtonText: "Petrol")
        return node
    }()

    private var addVehicleButton: SmallButtonNode?

    private lazy var header: HeaderListPopUpNode = {
        let node = HeaderListPopUpNode(state: .newvehicle)
        node.style.width = ASDimensionMake("100%")
        return node
    }()

    // MARK: - Privates

    private var vehicle: Vehicle?

    init(vehicle: Vehicle?) {
        super.init(node: ASDisplayNode())
        if let vehicle = vehicle {
            self.vehicle = vehicle
            manufacturerFormNode.setSelected(text: "\(vehicle.manufacture ?? "")")
            modelFormNode.setSelected(text: "\(vehicle.name ?? "")")
            odometerFormNode.changeText(text: "\(vehicle.odometer ?? 0)")
            licensePlateFormNode.changeText(text: "\(vehicle.licensePlate ?? "")")
            manufacturedYearFormNode.changeText(text: "\(vehicle.manufacturedYear ?? "")")
            ccFormNode.changeText(text: "\(vehicle.capacity ?? 0)")
            
//            switch vehicle.fuelType {
//            case VehicleFuelType.petrol.rawValue:
//                
//            case VehicleFuelType.diesel.rawValue:
//            }
            
        }
        manufacturedYearFormNode.delegate = self
        ccFormNode.delegate = self
        node.automaticallyManagesSubnodes = true
        node.backgroundColor = .white
        
        addVehicleButton = SmallButtonNode(title: "Add Vehicle", buttonState: .GreyButton, function: {
            //TODO: add vehicle Action
            print("add vehicle Action")
        })

        node.layoutSpecBlock = { _, _ in
            let stack = ASStackLayoutSpec(
                direction: .vertical,
                spacing: 16,
                justifyContent: .center,
                alignItems: .start,
                children: [self.manufacturerFormNode, self.modelFormNode, self.odometerFormNode, self.licensePlateFormNode, self.manufacturedYearFormNode, self.ccFormNode, self.tranmissionStack, self.fuelTypeStack]
            )
            let addNewVehicleStack = ASStackLayoutSpec(
                direction: .vertical,
                spacing: 32,
                justifyContent: .center,
                alignItems: .center,
                children: [self.header, stack, self.addVehicleButton!]
            )

            stack.style.width = ASDimensionMake("100%")

            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: .topSafeArea, left: 16, bottom: .bottomSafeArea, right: 16), child: addNewVehicleStack)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AddNewVehicleViewController: ASEditableTextNodeDelegate {
    func editableTextNode(_ editableTextNode: ASEditableTextNode, shouldChangeTextIn _: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            editableTextNode.resignFirstResponder()
            return false
        }
        return true
    }
}

extension AddNewVehicleViewController: FormFieldStackDelegate {
    func openPickerView(sender: FormFieldStack) {
        let vc = PickerBottomSheetViewController()
        vc.configurePicker(sender: sender)
        // TODO: Ini di configure pickernya nanti masukin kaya optionsnya apa aja biar bisa dirubah di dalem
        let bottomSheetVC = BottomSheetViewController(wrapping: vc)
        navigationController?.present(bottomSheetVC, animated: true, completion: nil)
    }
}
