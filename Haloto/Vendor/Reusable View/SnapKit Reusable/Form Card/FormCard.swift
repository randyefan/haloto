//
//  FormCard.swift
//  Haloto
//
//  Created by Javier Fransiscus on 05/11/21.
//

import UIKit

class FormCard: UIView {
    private var formType: FormCardType?
    private var otpPin: String?

    private var phoneNumber: String?

    internal lazy var phoneNumberStack: FormField = {
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

    internal lazy var loginButton: LoginButton = {
        let temp = LoginButton()
        temp.switchButton(state: .disabled)
        return temp
    }()

    private lazy var dontHaveAccountLabel: UILabel = {
        let temp = UILabel()
        temp.attributedText = .font("Don't have an account?", size: 11, fontWeight: .medium, color: UIColor(named: "button-blue") ?? UIColor.black, alignment: .left, isTitle: false)
        return temp
    }()

    internal lazy var signUpButton: UIButton = {
        let temp = UIButton()
        temp.setAttributedTitle(.font("Sign Up", size: 11, fontWeight: .medium, color: UIColor(named: "button-blue") ?? UIColor.black, alignment: .left, underline: true, isTitle: false), for: .normal)
        return temp
    }()

    private lazy var signUpStack: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [dontHaveAccountLabel, signUpButton])
        temp.axis = .horizontal
        temp.spacing = 4
        return temp
    }()

    internal lazy var otpField: OneTimePasswordTextField = {
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

    internal lazy var phoneNumberLabel: UILabel = {
        let temp = UILabel()
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

    private lazy var onboardingTitle: UILabel = {
        let label = UILabel()
        label.attributedText = .font("Welcome to Haloto!", size: 18, fontWeight: .bold, color: .black, alignment: .center, underline: false, isTitle: true)
        return label
    }()

    private lazy var onboardingSubtitle: UILabel = {
        let label = UILabel()
        label.attributedText = .font("Please register your current vehicle", size: 12, fontWeight: .regular, color: .black, alignment: .center, underline: false, isTitle: true)

        return label
    }()

    private lazy var onboardingStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [onboardingTitle, onboardingSubtitle])
        stack.spacing = 0
        stack.axis = .vertical

        return stack
    }()

    internal lazy var onboardingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Onboarding-Add")
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    internal lazy var resendOTPButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(.font("Re-send OTP", size: 11, fontWeight: .medium, color: UIColor(named: "button-blue") ?? .black, alignment: .center), for: .normal)

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
        addSubview(calculateView)

        switch formType {
        case .OTP:
            addSubview(signUpStack)
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

            upperView.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
                make.bottom.equalTo(signUpStack.snp.top)
            }
            
            signUpStack.snp.makeConstraints { make in
                make.bottom.equalToSuperview().offset(-24)
                make.centerX.equalToSuperview()
            }

        case .Login:
            addSubview(signUpStack)
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
            calculateView.snp.makeConstraints { make in
                make.top.equalTo(loginButton.snp.bottom)
                make.bottom.equalToSuperview()
            }
            upperView.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
                make.bottom.equalTo(signUpStack.snp.top)
            }
            
            signUpStack.snp.makeConstraints { make in
                make.bottom.equalToSuperview().offset(-24)
                make.centerX.equalToSuperview()
            }

        case .empty:
            upperView.addSubview(onboardingStack)
            upperView.addSubview(onboardingImageView)

            onboardingImageView.snp.makeConstraints { make in
                make.center.equalTo(upperView).offset(24)
                make.leading.trailing.equalToSuperview().inset(12)
            }

            onboardingStack.snp.makeConstraints { make in
                make.bottom.equalTo(onboardingImageView.snp.top).inset(0)
                make.width.equalToSuperview()
            }
            
            upperView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
                
            }
        }


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
