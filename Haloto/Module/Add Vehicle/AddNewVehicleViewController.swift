//
//  AddNewVehicleViewController.swift
//  Haloto
//
//  Created by Javier Fransiscus on 09/11/21.
//

import AsyncDisplayKit
import UIKit
import RxCocoa
import RxSwift

class AddNewVehicleViewController: ASDKViewController<ASDisplayNode> {
    // MARK: - Components Node
    private lazy var manufacturerFormNode: SelectFieldStack = {
        let node = SelectFieldStack(title: "Manufacturer", placeholder: "Choose your vehicle manufacturer")
        node.delegate = self
        return node
    }()

    private lazy var modelFormNode: SelectFieldStack = {
        let node = SelectFieldStack(title: "Model", placeholder: "Choose your vehicle model")
        node.delegate = self
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
        // TODO: nanti pake view model set picker optionsn
        let node = FormFieldStack(isPicker: true, title: "Manufactured Year", text: manufacturedYearDefaultValue, pickerOptions: ["2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007"])
        return node
    }()

    private lazy var capacityFormNode: FormFieldStack = {
        // TODO: nanti pake view model set picker optionsn
        let node = FormFieldStack(isPicker: true, title: "CC", text: "\(capacityDefaultValue)", pickerOptions: ["1000", "1250", "1500", "1800", "2000"])
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

    // MARK: - Private Variable

    private var vehicle: Vehicle?
    private var stackFields: [ASDisplayNode.Type]?
    private var manufacturedYearDefaultValue = "2000"
    private var capacityDefaultValue = 0

    // MARK: - View Model
    private let viewModel = AddVehicleViewModel()
    
    // MARK: - Variable
    let manufacturer = PublishSubject<String>()
    let didTapSubmit = PublishSubject<Void>()
    
    // MARK: - Initializer
    init(vehicle: Vehicle?, type: NewVehicleFormType) {
        
        super.init(node: ASDisplayNode())
        
        switch type {
        case .add:
            print("add")
            addVehicleButton = SmallButtonNode(title: "Add Vehicle", buttonState: .Yellow, function: {
                if self.checkFields(){
                    if self.licensePlateFormNode.textField.textField.textView.text.count != 0 && self.odometerFormNode.textField.textField.textView.text.count != 0 {
                        self.didTapSubmit.onNext(())
                    }
                }else{
                    self.showToast(title: "Please fill in all forms")
                }
            })
        case .edit:
            
            guard let currentVehicle = vehicle else { return }

            self.vehicle = currentVehicle
            manufacturedYearDefaultValue = currentVehicle.manufacturedYear ?? ""
            capacityDefaultValue = currentVehicle.capacity ?? 0
            manufacturerFormNode.setSelected(text: "\(currentVehicle.manufacture ?? "")")
            modelFormNode.setSelected(text: "\(currentVehicle.name ?? "")")
            odometerFormNode.changeText(text: "\(currentVehicle.odometer ?? 0)")
            licensePlateFormNode.changeText(text: "\(currentVehicle.licensePlate ?? "")")
            manufacturedYearFormNode.changeText(text: "\(manufacturedYearDefaultValue)")
            capacityFormNode.changeText(text: "\(capacityDefaultValue)")

            guard let vehicleFuel = currentVehicle.fuelType else { return }
            guard let vehicleTranmission = currentVehicle.transmissionType else { return }

            if vehicleFuel.caseInsensitiveCompare("diesel") == .orderedSame {
                fuelTypeStack.setFirstButtonActive()
            } else {
                fuelTypeStack.setSecondButtonActive()
            }

            if vehicleTranmission.caseInsensitiveCompare("Automatic") == .orderedSame {
                tranmissionStack.setFirstButtonActive()
            } else {
                tranmissionStack.setSecondButtonActive()
            }

            
            addVehicleButton = SmallButtonNode(title: "Edit", buttonState: .Yellow, function: {
                //TODO: Edit action
                print("add edit action")
            })
        }


        capacityFormNode.delegate = self
        node.automaticallyManagesSubnodes = true
        node.backgroundColor = .white

 

        node.layoutSpecBlock = { _, _ in
            let stack = ASStackLayoutSpec(
                direction: .vertical,
                spacing: 16,
                justifyContent: .center,
                alignItems: .start,
                children: [self.manufacturerFormNode, self.modelFormNode, self.odometerFormNode, self.licensePlateFormNode, self.manufacturedYearFormNode, self.capacityFormNode, self.tranmissionStack, self.fuelTypeStack]
            )
            let addNewVehicleStack = ASStackLayoutSpec(
                direction: .vertical,
                spacing: 32,
                justifyContent: .center,
                alignItems: .center,
                children: [self.header, stack, self.addVehicleButton!]
            )

            stack.style.width = ASDimensionMake("100%")

            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: .topSafeArea, left: 16, bottom: .infinity, right: 16), child: addNewVehicleStack)
        }
        
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        registerObserver()
    }
    
    // MARK: - Observer Function
    
    private func bind() {
        let triggerViewDidLoad = Driver.just(())
        let triggerCurrentOdometer = odometerFormNode.textField.textField.textView.rx.text.orEmpty.asDriver()
        let triggerLicensePlat = licensePlateFormNode.textField.textField.textView.rx.text.orEmpty.asDriver()
        let triggerManufacturerFilled = manufacturer.asDriver(onErrorJustReturn: "")
        let triggerDidTapSubmit = didTapSubmit.asDriver(onErrorJustReturn: ())
        
        let input = AddVehicleViewModel.Input(viewDidLoad: triggerViewDidLoad,
                                              manufacturedFilled: triggerManufacturerFilled,
                                              currentOdometer: triggerCurrentOdometer,
                                              licensePlate: triggerLicensePlat,
                                              addVehicleDidTap: triggerDidTapSubmit)
        let output = viewModel.transform(input: input)
        
        output.listOfManufacture.drive(onNext: { [weak self] object in
            guard let self = self else { return }
            if object.status == 0 {
                self.showToast(title: object.message ?? "")
                return
            }
            
            self.viewModel.modelManufacture(responseModel: object)
        }).disposed(by: rx.disposeBag)
        
        output.listOfVehicleByManufacture.drive(onNext: { [weak self] object in
            guard let self = self else { return }
            if object.status == 0 {
                self.showToast(title: object.message ?? "")
                return
            }
            self.viewModel.modelVehicle(responseModel: object)
        }).disposed(by: rx.disposeBag)
        
        output.addVehicle.drive(onNext: { [weak self] object in
            guard let self = self else { return }
            if object.status == 0 {
                self.showToast(title: object.message ?? "")
                return
            }
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: rx.disposeBag)
    }
    
    private func registerObserver() {
        viewModel.vehicleSelected.asObserver().subscribe(onNext: { vehicle in
            self.setupView(vehicle: vehicle)
        }).disposed(by: rx.disposeBag)
    }
    
    // MARK: - Popup Functionality
    
    private func presentPopUpList(type: PopUpListState, manufacturer: [Manufacturer]? = nil, model: [Model]? = nil) {
        switch type {
        case .model:
            guard let model = model else { return }
            let vc = ListPopupViewController(state: .model)
            vc.modalPresentationStyle = .overFullScreen
            vc.model = model
            vc.modelSelectedClosure = { index in
                let vehicle = self.viewModel.listOfVehicle.value[index]
                self.viewModel.vehicleSelected.onNext(vehicle)
            }
            self.navigationController?.present(vc, animated: true, completion: nil)
        case .manufacturer:
            guard let manufacturer = manufacturer else { return }
            let vc = ListPopupViewController(state: .manufacturer)
            vc.modalPresentationStyle = .overFullScreen
            vc.manufacturer = manufacturer
            vc.manufacturerSelectedClosure = { manufacture in
                self.manufacturerFormNode.selectNode.setSelected(text: manufacture.name?.uppercased() ?? "")
                self.manufacturer.onNext(manufacture.name ?? "")
                self.node.setNeedsLayout()
            }
            self.navigationController?.present(vc, animated: true, completion: nil)
        default:
            break
        }
    }
    
    // MARK: - Setup View
    
    func setupView(vehicle: VehicleResponse) {
        modelFormNode.selectNode.setSelected(text: vehicle.name?.uppercased() ?? "")
        manufacturedYearFormNode.changeText(text: "\(vehicle.manufacturerYear ?? 0)")
        capacityFormNode.changeText(text: "\(vehicle.cc ?? 0)")
        
        tranmissionStack.isUserInteractionEnabled = false
        fuelTypeStack.isUserInteractionEnabled = false
        manufacturerFormNode.isUserInteractionEnabled = false
        capacityFormNode.isUserInteractionEnabled = false
        
        if vehicle.transmission?.type == "Manual" {
            tranmissionStack.setSecondButtonActive()
        } else {
            tranmissionStack.setFirstButtonActive()
        }
        
        if vehicle.fuelType == "gasoline" {
            fuelTypeStack.setSecondButtonActive()
        } else {
            fuelTypeStack.setFirstButtonActive()
        }
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
        
        vc.configurePicker(sender: sender, options: sender.getOptions(), defaultValue: sender.getDefaultValue())
        let bottomSheetVC = BottomSheetViewController(wrapping: vc)
        navigationController?.present(bottomSheetVC, animated: true, completion: nil)
    }
}

extension AddNewVehicleViewController: SelectFieldStackDelegate {
    func selectFieldDidTapped(_ sender: SelectFieldStack) {
        openList(sender: sender)
    }
}

extension AddNewVehicleViewController{

    func openList(sender: SelectFieldStack){
        if sender.title == "Manufacturer" {
            if let manufacturer = viewModel.manufacturerObjectList.value, manufacturer.count > 0 {
                presentPopUpList(type: .manufacturer, manufacturer: manufacturer)
            } else {
                self.showToast(title: "Manufacturer is Empty")
            }
        } else {
            if let model = viewModel.modelVehicleObjectList.value, model.count > 0 {
                presentPopUpList(type: .model, model: model)
            } else {
                self.showToast(title: "Model is Empty")
            }
        }
        
    }
    
    func checkFields() -> Bool{
        return true
    }
}
