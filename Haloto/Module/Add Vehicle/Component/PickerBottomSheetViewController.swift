//
//  PickerBottomSheetViewController.swift
//  Haloto
//
//  Created by Javier Fransiscus on 10/11/21.
//

import AsyncDisplayKit
import UIKit

class PickerBottomSheetViewController: ASDKViewController<ASDisplayNode> {
    var cc = ["1200", "1500", "3000"]
    private var pickerOptions: [String]? = []
    private var currentTextField: FormFieldStack?

    private lazy var pickerView: ViewWrapperNode<UIPickerView> = {
        let wrapperNode = ViewWrapperNode<UIPickerView>(createView: {
            let picker = UIPickerView()
            picker.delegate = self
            picker.dataSource = self
            return picker
        })
        wrapperNode.style.height = ASDimensionMake(150)
        wrapperNode.style.width = ASDimensionMake("100%")
        return wrapperNode
    }()

    override init() {
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        node.backgroundColor = .white
        node.layoutSpecBlock = { _, _ in
            ASInsetLayoutSpec(insets: UIEdgeInsets(top: .topSafeArea, left: 16, bottom: .bottomSafeArea, right: 16), child: self.pickerView)
        }
    }

    func configurePicker(sender: FormFieldStack, options: [String]? = ["1200", "1300", "1500"]) {
        currentTextField = sender
        pickerOptions = options
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension PickerBottomSheetViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in _: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
        if let count = pickerOptions?.count {
            return count
        }
        return 0
    }

    func pickerView(_: UIPickerView, titleForRow row: Int, forComponent _: Int) -> String? {
        return pickerOptions?[row]
    }

    func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent _: Int) {
        currentTextField?.changeText(text: pickerOptions?[row] ?? "")
        dismiss(animated: true) {}
    }
}
