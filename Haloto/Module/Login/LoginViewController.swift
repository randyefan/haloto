//
//  LoginViewController.swift
//  Haloto
//
//  Created by Javier Fransiscus on 03/11/21.
//

import SnapKit
import UIKit
// TODO: Handle typing and get the value of log in
class LoginViewController: UIViewController {
    private lazy var backgroundImageView: UIImageView = {
        let temp = UIImageView()
        temp.image = UIImage(named: "AppBackground")
        temp.contentMode = .scaleToFill
        return temp
    }()

    private lazy var iconImageView: UIImageView = {
        let temp = UIImageView()
        temp.image = UIImage(named: "AppLogo")
        return temp
    }()

    private lazy var titleNameImage: UIImageView = {
        let temp = UIImageView()
        temp.image = UIImage(named: "AppName-White")
        return temp
    }()

    private lazy var formCard: FormCard = {
        let temp = FormCard()
        temp.setupView(formType: .Login)
        return temp
    }()

    private lazy var titleStack: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [titleNameImage, iconImageView])
        temp.axis = .vertical
        temp.spacing = 12
        return temp
    }()

    private lazy var loginView: UIView = {
        let temp = UIView()
        temp.backgroundColor = .white

        return temp
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        formCard.delegate = self
        setupView()
    }
}

private extension LoginViewController {

    
    func setupView() {
        setupPushViewOnKeyboardAction()
        hideKeyboardWhenTappedAround()
        view.addSubview(loginView)
        loginView.addSubview(backgroundImageView)
        loginView.addSubview(formCard)
        loginView.addSubview(titleStack)

        formCard.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
            make.height.equalTo(Double(self.view.frame.height) * 0.6)
        }
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        iconImageView.snp.makeConstraints { make in
            make.height.equalTo(125)
            make.width.equalTo(125)
            make.centerY.equalTo(formCard.snp.top)
        }
        titleNameImage.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.width.equalTo(125)
        }

        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        titleStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
    }
}

extension LoginViewController: FormCardDelegate {
    func otpIsFilled(pin _: String) {}

    func attemptRequestOTP() {
        let vc = OTPViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    func signUpButtonIsPressed() {
        let vc = SignUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LoginViewController {
    
    @objc
    override func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
                self.view.frame.origin.y += formCard.getDifferenceViewHeight() - 30
            }
        }
    }
    
}
