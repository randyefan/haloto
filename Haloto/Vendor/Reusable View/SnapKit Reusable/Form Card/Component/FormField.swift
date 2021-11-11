//
//  FormField.swift
//  Haloto
//
//  Created by Javier Fransiscus on 03/11/21.
//

import SnapKit
import UIKit

protocol FormFieldDelegate {
    func fieldDidEnterCharacter()
    func fieldDidBecomeEmpty()
}

class FormField: UIView {
    var delegate: FormFieldDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private lazy var loginInfoLabel: UILabel = {
        let temp = UILabel()

        return temp
    }()

    lazy var loginInfoTextField: FormTextField = {
        let temp = FormTextField()
        return temp
    }()

    private lazy var loginStack: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [loginInfoLabel, loginInfoTextField])
        temp.axis = .vertical
        temp.spacing = 8
        return temp
    }()

    func setText(textTitle: String, placeHolder: String) {
        loginInfoLabel.attributedText = .font("\(textTitle)", size: 11, fontWeight: .medium, color: UIColor(named: "button-title-black") ?? UIColor.black, alignment: .left, isTitle: true)
        loginInfoTextField.attributedPlaceholder = .font("\(placeHolder)", size: 12, fontWeight: .regular, color: UIColor(hexString: "B6B6B6"), alignment: .left, underline: false, isTitle: false)
    }

    func setKeyboardType(keyboardType _: UIKeyboardType) {
        loginInfoTextField.keyboardType = .numberPad
    }

    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
         // Drawing code
     }
     */
}

fileprivate extension FormField {
    func setupView() {
        addSubview(loginStack)
        loginInfoTextField.delegate = self

        snp.makeConstraints { make in
            make.height.equalTo(loginStack)
        }

        loginStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }
}


extension FormField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let userEnteredString = textField.text
        let newString = (userEnteredString! as NSString).replacingCharacters(in: range, with: string) as NSString
        if newString != "" {
            //Enabled
            delegate?.fieldDidEnterCharacter()
        } else {
            //Disabled
            delegate?.fieldDidBecomeEmpty()
        }
        return true
    }
}
