//
//  OTPViewController.swift
//  Haloto
//
//  Created by Javier Fransiscus on 04/11/21.
//

import UIKit

class OTPViewController: UIViewController {
    private lazy var iconImageView: UIImageView = {
        let temp = UIImageView()
        temp.image = UIImage(named: "AppLogo")
        return temp
    }()

    private lazy var titleNameLabel: UILabel = {
        let temp = UILabel()
        temp.attributedText = .font("HalOto", size: 34, fontWeight: .bold, color: UIColor(named: "button-blue") ?? UIColor.black, alignment: .center, isTitle: true)
        temp.textAlignment = .center
        return temp
    }()

    private lazy var lineView: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor(named: "button-blue")
        return temp
    }()

    private lazy var loginButton: LoginButton = {
        let temp = LoginButton()
        temp.setTitle(title: "Login")
        temp.addTarget(self, action: #selector(loginButtonIsPressed), for: .touchUpInside)
        return temp
    }()

    private lazy var otpStack: FormField = {
        let temp = FormField()
        temp.setText(textTitle: "OTP", placeHolder: "OTP")
        return temp
    }()

    private lazy var titleStack: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [titleNameLabel, iconImageView])
        temp.axis = .vertical
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

private extension OTPViewController {
    func setupView() {
        view.addSubview(loginView)
        view.backgroundColor = UIColor.white
        loginView.addSubview(titleStack)
        loginView.addSubview(otpStack)
        loginView.addSubview(signUpStack)
        loginView.addSubview(loginButton)
        loginView.addSubview(lineView)
        iconImageView.snp.makeConstraints { make in
            make.height.equalTo(170)
            make.width.equalTo(170)
        }
        loginView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }

        otpStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        titleStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(self.view.snp.centerY).offset(-32)
        }
        signUpStack.snp.makeConstraints { make in
            make.bottom.equalTo(loginView.snp.bottom)
            make.centerX.equalToSuperview()
        }
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(otpStack.snp.bottom).offset(16)
            make.bottom.equalTo(lineView.snp.top).offset(-21)
        }
        lineView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(0.5)
            make.bottom.equalTo(signUpStack.snp.top).offset(-21)
        }
    }

    @objc
    func signUpButtonIsPressed() {
        let vc = SignUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func loginButtonIsPressed(){
        
    }
}
