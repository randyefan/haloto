//
//  AddNewVehicleViewController.swift
//  Haloto
//
//  Created by Javier Fransiscus on 09/11/21.
//

import AsyncDisplayKit
import UIKit

class AddNewVehicleViewController: ASDKViewController<ASDisplayNode> {
    var bizCat = ["1200", "1500", "3000"]

    private lazy var pickerView: ViewWrapperNode<UIPickerView> = {
        let wrapperNode = ViewWrapperNode<UIPickerView>(createView: {
            let picker = UIPickerView()
            picker.delegate = self
            picker.dataSource = self
            return picker
        })

        return wrapperNode
    }()

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
    
    private lazy var buttonStack: ButtonFieldStack = {
       let node = ButtonFieldStack(title: "Transmission", firstButtonText: "Matic", secondButtonText: "Manual")
       return node
    }()

    override init() {
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        node.backgroundColor = .white
        
        let stack = ASStackLayoutSpec(direction: .vertical, spacing: 16, justifyContent: .center, alignItems: .start, children: [manufacturerFormNode, modelFormNode, odometerFormNode, licensePlateFormNode, manufacturedYearFormNode, ccFormNode, buttonStack])
        stack.style.width = ASDimensionMake("100%")
        pickerView.isHidden = false
        node.layoutSpecBlock = { _, _ in
            ASInsetLayoutSpec(insets: UIEdgeInsets(top: .infinity, left: 16, bottom: .infinity, right: 16), child: stack)
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

extension AddNewVehicleViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bizCat.count
    }
    
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return bizCat[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent _: Int) {
        odometerFormNode.changeText(text: bizCat[row])
        pickerView.isHidden = true
    }

    func textFieldShouldBeginEditing(_: UITextField) -> Bool {
        pickerView.isHidden = false
        return false
    }
}
