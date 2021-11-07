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
//TODO: Form card delegate to fill when the otp is done
class FormCard: UIView {
    weak var delegate: FormCardDelegate?

    private var phoneNumber: String?

    private lazy var phoneNumberStack: FormField = {
        let temp = FormField()
        temp.setText(textTitle: "Phone Number", placeHolder: "Phone Number")
        temp.setKeyboardType(keyboardType: .numberPad)
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

    private lazy var otpField: OneTimePasswordTextField = {
        let temp = OneTimePasswordTextField()
        temp.configure(with: 4)
        temp.didEnterLastDigit = { [weak self] otpPin in
            print(otpPin)
        }
        return temp
    }()

    private lazy var titleLabel: UILabel = {
        let temp = UILabel()
        temp.attributedText = .font("Verification Code", size: 18, fontWeight: .bold, color: .black, alignment: .center, underline: false, isTitle: false)
        return temp
    }()

    private lazy var subtitleLabel: UILabel = {
        let temp = UILabel()
        temp.attributedText = .font("Please type the verification code sent to:", size: 12, fontWeight: .regular, color: UIColor(hexString: "707070"), alignment: .center, underline: false, isTitle: false)
        return temp
    }()

    private lazy var phoneNumberLabel: UILabel = {
        let temp = UILabel()
        temp.attributedText = .font("+62 812 3456 7890", size: 12, fontWeight: .regular, color: .black, alignment: .center, underline: false, isTitle: false)
        return temp
    }()

    private lazy var otpMiddleStack: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, phoneNumberLabel, otpField])
        temp.axis = .vertical
        temp.spacing = 20
        return temp
    }()

    private lazy var loginMiddleStack: UIStackView = {
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

    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.topLeft, .topRight], radius: 43)
    }
}

extension FormCard {
    func setupView(formType: FormCardType) {
        backgroundColor = .white
        addSubview(upperView)
        addSubview(lineView)
        addSubview(signUpStack)

        switch formType {
        case .OTP:
            upperView.addSubview(otpMiddleStack)
            otpMiddleStack.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().offset(33)
                make.trailing.equalToSuperview().offset(-33)
            }
            otpField.snp.makeConstraints { make in
                make.height.equalTo(40)
            }
        case .Login:
            upperView.addSubview(loginMiddleStack)
            loginMiddleStack.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().offset(33)
                make.trailing.equalToSuperview().offset(-33)
            }
            phoneNumberStack.snp.makeConstraints { make in
                make.width.equalToSuperview()
            }
        }

        upperView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(lineView.snp.top)
        }

        signUpStack.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
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
