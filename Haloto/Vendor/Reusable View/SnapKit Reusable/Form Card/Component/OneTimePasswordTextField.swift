//
//  OneTimePasswordTextField.swift
//  Haloto
//
//  Created by Javier Fransiscus on 06/11/21.
//

import SnapKit
import UIKit

protocol OneTimePasswordTextFieldDelegate: AnyObject {
    func didEnterLastDigit(pin: String)
    func didRemoveText()
}

class OneTimePasswordTextField: UITextField {
    var defaultCharacter = "-"

    var otpDelegate: OneTimePasswordTextFieldDelegate?

    private var isConfigured = false
    private var digitLabels = [UILabel]()
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(becomeFirstResponder))
        return recognizer
    }()

    func configure(with slotCount: Int = 4) {
        guard isConfigured == false else { return }
        isConfigured.toggle()

        configureTextField()

        let labelsStackView = createLablesStackView(with: slotCount)
        addSubview(labelsStackView)

        addGestureRecognizer(tapRecognizer)

        labelsStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.center.equalToSuperview()
        }
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}

private extension OneTimePasswordTextField {
    func configureTextField() {
        tintColor = .clear
        textColor = .clear
        backgroundColor = .clear
        keyboardType = .numberPad
        textContentType = .oneTimeCode
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        delegate = self
    }

    func createLablesStackView(with count: Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = true
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 13

        for _ in 1 ... count {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.font = UIFont(name: "Poppins-Bold", size: 18)
            label.layer.borderColor = UIColor.darkGray.cgColor
            label.layer.borderWidth = 1
            label.cornerRadius = 5
            label.text = defaultCharacter

            label.isUserInteractionEnabled = true

            stackView.addArrangedSubview(label)
            label.snp.makeConstraints { make in
                make.width.equalTo(40)
            }

            digitLabels.append(label)
        }

        return stackView
    }

    @objc
    func textDidChange() {
        guard let text = text, text.count <= digitLabels.count else { return }

        for i in 0 ..< digitLabels.count {
            let currentLabel = digitLabels[i]

            if i < text.count {
                let index = text.index(text.startIndex, offsetBy: i)
                currentLabel.text = String(text[index])
            } else {
                currentLabel.text = defaultCharacter
                otpDelegate?.didRemoveText()
            }
        }

        if text.count == digitLabels.count {
            otpDelegate?.didEnterLastDigit(pin: text)
        }
    }
}

extension OneTimePasswordTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn _: NSRange, replacementString string: String) -> Bool {
        guard let characterCount = textField.text?.count else { return false }
        return characterCount < digitLabels.count || string == ""
    }
}
