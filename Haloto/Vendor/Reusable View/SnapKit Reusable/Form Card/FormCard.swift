//
//  FormCard.swift
//  Haloto
//
//  Created by Javier Fransiscus on 05/11/21.
//

import UIKit
protocol FormCardDelegate: AnyObject {
    func attemptRequestOTP()
    func signUpButtonIsPressed()
}

class FormCard: UIView {
    weak var delegate: FormCardDelegate?

    private lazy var phoneNumberStack: Form = {
        let temp = Form()
        temp.setText(textTitle: "Phone Number", placeHolder: "Phone Number")
        return temp
    }()

    private lazy var otpLabel: UILabel = {
        let temp = UILabel()
        temp.attributedText = .font("We will send you a One Time Password (OTP)", size: 12, fontWeight: .regular, color: UIColor(hexString: "707070"), alignment: .center, underline: false, isTitle: false)
        temp.numberOfLines = 2
        return temp
    }()

    private lazy var loginButton: LoginButton = {
        let temp = LoginButton()
        temp.setTitle(title: "Login")
        temp.addTarget(self, action: #selector(requestOTPIsPressed), for: .touchUpInside)
        return temp
    }()

    private lazy var dontHaveAccountLabel: UILabel = {
        let temp = UILabel()
        temp.attributedText = .font("Don't have an account?", size: 18, fontWeight: .bold, color: UIColor(named: "button-blue") ?? UIColor.black, alignment: .left, isTitle: true)
        return temp
    }()

    private lazy var signUpButton: UIButton = {
        let temp = UIButton()
        temp.setAttributedTitle(.font("Sign Up", size: 18, fontWeight: .bold, color: UIColor(named: "button-blue") ?? UIColor.black, alignment: .left, underline: true, isTitle: true), for: .normal)
        temp.addTarget(self, action: #selector(signUpButtonIsPressed), for: .touchUpInside)
        return temp
    }()

    private lazy var signUpStack: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [dontHaveAccountLabel, signUpButton])
        temp.axis = .horizontal
        temp.spacing = 4
        return temp
    }()

    private lazy var lineView: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor(named: "button-blue")
        return temp
    }()

    private lazy var middleStack: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [phoneNumberStack, loginButton, otpLabel])
        temp.axis = .vertical
        temp.spacing = 40
        temp.alignment = .center
        return temp
    }()

    private lazy var upperView: UIView = {
        let temp = UIView()
        return temp
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.topLeft, .topRight], radius: 43)
    }
}

private extension FormCard {
    func setupView() {
        backgroundColor = .white
        addSubview(upperView)
        upperView.addSubview(middleStack)
        addSubview(lineView)
        addSubview(signUpStack)
        phoneNumberStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        upperView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalTo(lineView.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        middleStack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        signUpStack.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
        }
        loginButton.snp.makeConstraints { _ in
            
        }
        lineView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(0.5)
            make.bottom.equalTo(signUpStack.snp.top).offset(-20)
        }
    }

    @objc
    func requestOTPIsPressed() {
        delegate?.attemptRequestOTP()
    }

    @objc
    func signUpButtonIsPressed() {
        delegate?.signUpButtonIsPressed()
    }
}