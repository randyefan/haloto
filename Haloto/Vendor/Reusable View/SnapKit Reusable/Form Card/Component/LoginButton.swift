//
//  MainButton.swift
//  Haloto
//
//  Created by Javier Fransiscus on 03/11/21.
//

import SnapKit
import UIKit

enum LoginButtonState {
    case enabled
    case disabled
}

class LoginButton: UIButton {
    
    override var isEnabled: Bool {
        didSet {
            switch isEnabled {
            case true:
                backgroundColor = UIColor(named: "button-yellow")
            case false:
                backgroundColor = UIColor(named: "button-disable")
            }
        }
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupButton()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setTitle(title: String) {
        setAttributedTitle(.font("\(title)", size: 11, fontWeight: .medium, color: UIColor(hexString: "2D2D2D"), alignment: .center, underline: false, isTitle: false), for: .normal)
    }

    func switchButton(state: LoginButtonState) {
        switch state {
        case .enabled:
            isEnabled = true
            backgroundColor = UIColor(named: "button-yellow")
        case .disabled:
            isEnabled = false
            backgroundColor = UIColor(named: "button-disable")
        }
    }
}

private extension LoginButton {
    func setupButton() {
        backgroundColor = UIColor(named: "button-yellow")
        cornerRadius = 22
        snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(172)
        }
    }
}
