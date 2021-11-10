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

    func configurePicker(sender: FormFieldStack) {
        currentTextField = sender
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}

extension PickerBottomSheetViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in _: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
        return cc.count
    }

    func pickerView(_: UIPickerView, titleForRow row: Int, forComponent _: Int) -> String? {
        return cc[row]
    }

    func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent _: Int) {
        currentTextField?.changeText(text: cc[row])
        dismiss(animated: true) {}
    }
}
