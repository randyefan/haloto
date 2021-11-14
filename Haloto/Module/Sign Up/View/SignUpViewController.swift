//
//  SignUpViewController.swift
//  Haloto
//
//  Created by Javier Fransiscus on 03/11/21.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {
    
    //MARK: - Components
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

    private lazy var signUpButton: LoginButton = {
        let temp = LoginButton()
        temp.setTitle(title: "Sign Up")
        temp.addTarget(self, action: #selector(signUpButtonIsPressed), for: .touchUpInside)
        return temp
    }()

    private lazy var phoneNumberStack: FormField = {
        let temp = FormField()
        temp.setText(textTitle: "Phone Number", placeHolder: "0812345678")
        temp.setKeyboardType(keyboardType: .numberPad)
        return temp
    }()
    
    private lazy var calculateView: UIView = {
        let temp = UIView()
        temp.backgroundColor = .red
        return temp
    }()

    private lazy var nameStack: FormField = {
        let temp = FormField()
        temp.setText(textTitle: "Name", placeHolder: "Ex. Martin Martini")
        return temp
    }()

    private lazy var emailStack: FormField = {
        let temp = FormField()
        temp.setText(textTitle: "Email", placeHolder: "Ex. Martin.Martini@user.id")
        return temp
    }()

    private lazy var formStackView: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [nameStack, emailStack, phoneNumberStack])
        temp.axis = .vertical
        temp.spacing = 9
        return temp
    }()

    private lazy var titleStack: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [iconImageView, titleNameImage])
        temp.axis = .horizontal
        temp.alignment = .center
        temp.spacing = 12
        return temp
    }()

    private lazy var alreadyHaveAnAccountLabel: UILabel = {
        let temp = UILabel()
        temp.attributedText = .font("Already have an account?", size: 11, fontWeight: .medium, color: UIColor(named: "button-blue") ?? UIColor.black, alignment: .left, isTitle: false)
        return temp
    }()

    private lazy var loginButton: UIButton = {
        let temp = UIButton()
        temp.setAttributedTitle(.font("Login", size: 11, fontWeight: .medium, color: UIColor(named: "button-blue") ?? UIColor.black, alignment: .left, underline: true, isTitle: false), for: .normal)
        temp.addTarget(self, action: #selector(loginButtonInPressed), for: .touchUpInside)
        return temp
    }()

    private lazy var loginStack: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [alreadyHaveAnAccountLabel, loginButton])
        temp.axis = .horizontal
        temp.spacing = 4
        return temp
    }()

    private lazy var signUpView: UIView = {
        let temp = UIView()
        temp.backgroundColor = .white

        return temp
    }()
    
    //MARK: - Variables
    private let viewModel = SignUpViewModel()

    //MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupBindings()
    }
    
    //MARK: - Setup Bindings
    private func setupBindings(){
        nameStack.loginInfoTextField.rx.text
            .orEmpty
            .bind(to: viewModel.name)
            .disposed(by: rx.disposeBag)
        
        emailStack.loginInfoTextField.rx.text
            .orEmpty
            .bind(to: viewModel.email)
            .disposed(by: rx.disposeBag)
        
        phoneNumberStack.loginInfoTextField.rx.text
            .orEmpty
            .bind(to: viewModel.phone)
            .disposed(by: rx.disposeBag)
        
        viewModel.isFilled
            .bind(to: signUpButton.rx.isEnabled)
            .disposed(by: rx.disposeBag)
        
        viewModel.successRegister
            .subscribe(onNext: { response in
                print("INI RESPONSENYAAAAA \(response)")
                self.navigateToOTP()
                
            }).disposed(by: rx.disposeBag)
        
        signUpButton.rx.tap
            .subscribe(onNext: {
                self.viewModel.submitDidTap.onNext(true)
            })
            .disposed(by: rx.disposeBag)

    }
    
    func navigateToOTP(){
        let OTPViewModel = OTPViewModel(phone: Driver.just(viewModel.phone.value))
        let vc = OTPViewController(viewModel: OTPViewModel)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

private extension SignUpViewController {
    func setupView() {
        setupPushViewOnKeyboardAction()
        hideKeyboardWhenTappedAround()
        navigationController?.navigationBar.isHidden = true
        view.addSubview(signUpView)
        view.addSubview(calculateView)
        view.backgroundColor = UIColor.white
        signUpView.addSubview(titleStack)
        signUpView.addSubview(formStackView)
        signUpView.addSubview(loginStack)
        signUpView.addSubview(signUpButton)
        iconImageView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        titleNameImage.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.width.equalTo(108)
        }
        signUpView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }

        formStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.center.equalTo(self.view.snp.center)
        }
        titleStack.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(32)
        }
        loginStack.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-24)
            make.centerX.equalToSuperview()
        }
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(formStackView.snp.bottom).offset(16)

        }
        calculateView.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }

    @objc
    func signUpButtonIsPressed() {}

    @objc
    func loginButtonInPressed() {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension SignUpViewController {
    func getDifferenceViewHeight() -> CGFloat {
        return calculateView.frame.height
    }
}

extension SignUpViewController {
    
    @objc
    override func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
                self.view.frame.origin.y += getDifferenceViewHeight() - 30
            }
        }
    }
    
}
