//
//  LoginViewController.swift
//  Haloto
//
//  Created by Javier Fransiscus on 03/11/21.
//

import SnapKit
import UIKit
import RxCocoa

class OTPViewController: UIViewController {
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
        temp.setupView(formType: .OTP)
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

    private let viewModel: OTPViewModel

    init(viewModel: OTPViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
}

private extension OTPViewController {
    func setupView() {
        navigationController?.navigationBar.isHidden = true
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

    func bindViewModel() {
        let textFieldTrigger = formCard.otpField.rx.text.orEmpty.asDriver()
        let submit = formCard.loginButton.rx.tap.asDriver()
        let tapResendOtp = formCard.resendOTPButton.rx.tap.asDriver()
        let signUpTrigger = formCard.signUpButton.rx.tap.asDriver()

        let output = viewModel.transform(input: .init(
            textFieldTriger: textFieldTrigger,
            submit: submit,
            resendOtpDidTap: tapResendOtp,
            tapSignUp: signUpTrigger)
        )

        output.OTPResent.drive(onNext: { _ in
            print("HARAP DIGANTI DISINI MENJADI RESET TIMER")
        }).disposed(by: rx.disposeBag)

//        output.signUpDidTap.drive(onNext: { [weak self] _ in
//            guard let self = self else { return }
//            let vc = SignUpViewController()
//            self.navigationController?.pushViewController(vc, animated: true)
//        }).disposed(by: rx.disposeBag)

        output.OTPMatched.drive(onNext: { token in
            if !token.isEmpty {
                let tabBar = TabBarBaseController(productLogin: .User)
                let keyWindow = UIApplication.shared.connectedScenes
                    .filter({ $0.activationState == .foregroundActive })
                    .compactMap({ $0 as? UIWindowScene })
                    .first?.windows
                    .filter({ $0.isKeyWindow }).first
                keyWindow?.rootViewController = tabBar
                keyWindow?.makeKeyAndVisible()
                DefaultManager.shared.set(value: token, forKey: .AccessTokenKey)
            }
        }).disposed(by: rx.disposeBag)

        output
            .phone.map { NSAttributedString.font($0, size: 12, alignment: .center) }
            .drive(formCard.phoneNumberLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
    }
}

extension OTPViewController {
    @objc
    override func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= keyboardSize.height
                view.frame.origin.y += formCard.getDifferenceViewHeight() - 30
            }
        }
    }
}
