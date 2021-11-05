//
//  SignUpViewController.swift
//  Haloto
//
//  Created by Javier Fransiscus on 03/11/21.
//

import UIKit

class SignUpViewController: UIViewController {
    private lazy var iconImageView: UIImageView = {
        let temp = UIImageView()
        temp.image = UIImage(named: "AppLogo")
        return temp
    }()

    private lazy var titleNameImage: UIImageView = {
        let temp = UIImageView()
        temp.image = UIImage(named: "AppName-Blue")
        return temp
    }()

    private lazy var lineView: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor(named: "button-blue")
        return temp
    }()

    private lazy var signUpButton: LoginButton = {
        let temp = LoginButton()
        temp.setTitle(title: "Sign Up")
        temp.addTarget(self, action: #selector(signUpButtonIsPressed), for: .touchUpInside)
        return temp
    }()

    private lazy var phoneNumberStack: FormField = {
        let temp = FormField()
        temp.setText(textTitle: "Phone Number", placeHolder: "Phone Number")
        temp.setKeyboardType(keyboardType: .numberPad)
        return temp
    }()
    
    private lazy var nameStack: FormField = {
        let temp = FormField()
        temp.setText(textTitle: "Name", placeHolder: "Full Name")
        return temp
    }()
    
    private lazy var emailStack: FormField = {
        let temp = FormField()
        temp.setText(textTitle: "Email", placeHolder: "Email")
        return temp
    }()
    
    private lazy var formStackView: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [emailStack, nameStack, phoneNumberStack])
        temp.axis = .vertical
        temp.spacing = 9
        return temp
    }()

    private lazy var titleStack: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [iconImageView, titleNameImage])
        temp.axis = .horizontal
        temp.alignment = .center
        temp.spacing = 9
        return temp
    }()

    private lazy var alreadyHaveAnAccountLabel: UILabel = {
        let temp = UILabel()
        temp.attributedText = .font("Already have an account?", size: 18, fontWeight: .bold, color: UIColor(named: "button-blue") ?? UIColor.black, alignment: .left, isTitle: true)
        return temp
    }()

    private lazy var loginButton: UIButton = {
        let temp = UIButton()
        temp.setAttributedTitle(.font("Login", size: 18, fontWeight: .bold, color: UIColor(named: "button-blue") ?? UIColor.black, alignment: .left, underline: true, isTitle: true), for: .normal)
        temp.addTarget(self, action: #selector(loginButtonInPressed), for: .touchUpInside)
        return temp
    }()

    private lazy var loginStack: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [alreadyHaveAnAccountLabel, loginButton])
        temp.axis = .horizontal
        temp.spacing = 4
        return temp
    }()

    private lazy var loginView: UIView = {
        let temp = UIView()
        temp.backgroundColor = .white

        return temp
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
}

private extension SignUpViewController {
    func setupView() {
        navigationController?.navigationBar.isHidden = true
        view.addSubview(loginView)
        view.backgroundColor = UIColor.white
        loginView.addSubview(titleStack)
        loginView.addSubview(formStackView)
        loginView.addSubview(loginStack)
        loginView.addSubview(signUpButton)
        loginView.addSubview(lineView)
        iconImageView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        titleNameImage.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.width.equalTo(108)
        }
        loginView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }

        formStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        titleStack.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(32)
        }
        loginStack.snp.makeConstraints { make in
            make.bottom.equalTo(loginView.snp.bottom)
            make.centerX.equalToSuperview()
        }
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(formStackView.snp.bottom).offset(16)
            make.bottom.equalTo(lineView.snp.top).offset(-21)
        }
        lineView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(0.5)
            make.bottom.equalTo(loginStack.snp.top).offset(-21)
        }
    }

    @objc
    func signUpButtonIsPressed() {}

    @objc
    func loginButtonInPressed() {
        navigationController?.popToRootViewController(animated: true)
    }
}

