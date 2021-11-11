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
    func otpIsFilled(pin: String)
}

// TODO: Form card delegate to fill when the otp is done
class FormCard: UIView {
    weak var delegate: FormCardDelegate?
    private var formType: FormCardType?
    private var otpPin: String?

    private var phoneNumber: String?

    private lazy var phoneNumberStack: FormField = {
        let temp = FormField()
        temp.setText(textTitle: "Phone Number", placeHolder: "Phone Number")
        temp.setKeyboardType(keyboardType: .numberPad)
        return temp
    }()

    private lazy var otpLabel: UILabel = {
        let temp = UILabel()
        temp.attributedText = .font("We will send you a One Time Password (OTP) to your phone number", size: 12, fontWeight: .regular, color: UIColor(hexString: "707070"), alignment: .center, underline: false, isTitle: false)
        temp.numberOfLines = 2
        return temp
    }()

    private lazy var loginButton: LoginButton = {
        let temp = LoginButton()
        temp.switchButton(state: .disabled)
        return temp
    }()

    private lazy var dontHaveAccountLabel: UILabel = {
        let temp = UILabel()
        temp.attributedText = .font("Don't have an account?", size: 11, fontWeight: .medium, color: UIColor(named: "button-blue") ?? UIColor.black, alignment: .left, isTitle: false)
        return temp
    }()

    private lazy var signUpButton: UIButton = {
        let temp = UIButton()
        temp.setAttributedTitle(.font("Sign Up", size: 11, fontWeight: .medium, color: UIColor(named: "button-blue") ?? UIColor.black, alignment: .left, underline: true, isTitle: false), for: .normal)
        temp.addTarget(self, action: #selector(signUpButtonIsPressed), for: .touchUpInside)
        return temp
    }()

    private lazy var signUpStack: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [dontHaveAccountLabel, signUpButton])
        temp.axis = .horizontal
        temp.spacing = 4
        return temp
    }()

    private lazy var otpField: OneTimePasswordTextField = {
        let temp = OneTimePasswordTextField()
        temp.configure(with: 4)
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
        temp.spacing = 10
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

    private lazy var calculateView: UIView = {
        let temp = UIView()
        temp.backgroundColor = .red
        return temp
    }()

    private lazy var resendOTPButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(.font("Re-send OTP", size: 11, fontWeight: .medium, color: UIColor(named: "button-blue") ?? .black, alignment: .center), for: .normal)
        button.addTarget(self, action: #selector(attemptRequestOTP), for: .touchUpInside)
        return button
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.topLeft, .topRight], radius: 43)
    }
}

extension FormCard {
    func setupView(formType: FormCardType) {
        otpField.otpDelegate = self
        phoneNumberStack.delegate = self
        self.formType = formType
        backgroundColor = .white
        addSubview(upperView)
        addSubview(signUpStack)
        addSubview(calculateView)

        switch formType {
        case .OTP:
            upperView.addSubview(otpMiddleStack)
            upperView.addSubview(loginButton)
            upperView.addSubview(resendOTPButton)
            otpMiddleStack.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(75)
                make.leading.equalToSuperview().offset(33)
                make.trailing.equalToSuperview().offset(-33)
            }
            otpField.snp.makeConstraints { make in
                make.height.equalTo(40)
            }
            loginButton.setTitle(title: "Verify")
            loginButton.addTarget(self, action: #selector(verifyOTP), for: .touchUpInside)
            loginButton.snp.makeConstraints { make in
                make.top.equalTo(otpMiddleStack.snp.bottom).offset(28)
                make.centerX.equalToSuperview()
            }

            resendOTPButton.snp.makeConstraints { make in
                make.top.equalTo(loginButton.snp.bottom).offset(16)
                make.centerX.equalToSuperview()
            }
            calculateView.snp.makeConstraints { make in
                make.top.equalTo(resendOTPButton.snp.bottom)
                make.bottom.equalToSuperview()
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
            loginButton.setTitle(title: "Login")
            loginButton.addTarget(self, action: #selector(requestOTPIsPressed), for: .touchUpInside)
            calculateView.snp.makeConstraints { make in
                make.top.equalTo(loginButton.snp.bottom)
                make.bottom.equalToSuperview()
            }
        }

        upperView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(signUpStack.snp.top)
        }

        signUpStack.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-24)
            make.centerX.equalToSuperview()
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

    @objc
    func attemptRequestOTP() {
        print("requesting OTP")
    }

    @objc
    func verifyOTP() {
        guard let otp = otpPin else { return }
        delegate?.otpIsFilled(pin: otp)
    }
}

extension FormCard: OneTimePasswordTextFieldDelegate {
    func didRemoveText() {
        loginButton.switchButton(state: .disabled)
    }

    func didEnterLastDigit(pin: String) {
        otpPin = pin
        loginButton.switchButton(state: .enabled)
    }
}

extension FormCard {
    func getDifferenceViewHeight() -> CGFloat {
        return calculateView.frame.height
    }
}

extension FormCard: FormFieldDelegate {
    func fieldDidEnterCharacter() {
        loginButton.switchButton(state: .enabled)
    }

    func fieldDidBecomeEmpty() {
        loginButton.switchButton(state: .disabled)
    }
}
