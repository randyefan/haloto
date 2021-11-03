//
//  LoginViewController.swift
//  Haloto
//
//  Created by Javier Fransiscus on 03/11/21.
//

import SnapKit
import UIKit

class LoginViewController: UIViewController {
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

    private lazy var loginInfoLabel: UILabel = {
        let temp = UILabel()
        temp.attributedText = .font("Phone Number", size: 11, fontWeight: .medium, color: UIColor(named: "button-blue") ?? UIColor.black, alignment: .left, isTitle: true)
        return temp
    }()

    private lazy var loginInfoTextField: UITextField = {
        let temp = UITextField()
        temp.placeholder = "Phone Number"
        temp.cornerRadius = 5
        temp.borderColor = UIColor.gray
        temp.borderWidth = 2
        temp.borderStyle = .bezel
        return temp
    }()

    private lazy var loginStack: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [loginInfoLabel, loginInfoTextField])
        temp.axis = .vertical
        temp.spacing = 8
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
        //TODO: Tambahin title underline
        temp.setAttributedTitle(.font("Sign Up", size: 18, fontWeight: .bold, color: UIColor(named: "button-blue") ?? UIColor.black, alignment: .left, isTitle: true), for: .normal)
        temp.addTarget(self, action: #selector(signUpButtonIsPressed), for: .touchUpInside)
        return temp
    }()

    private lazy var signUpStack: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [dontHaveAccountLabel, signUpButton])
        temp.axis = .horizontal
        temp.spacing = 4
        return temp
    }()

    private lazy var formStack: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [loginStack])
        temp.axis = .vertical
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
        // Do any additional setup after loading the view.
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}

private extension LoginViewController {
    func setupView() {
        view.addSubview(loginView)
        view.backgroundColor = UIColor.white
        loginView.addSubview(titleStack)
        loginView.addSubview(formStack)
        loginView.addSubview(signUpStack)
        iconImageView.snp.makeConstraints { make in
            make.height.equalTo(170)
            make.width.equalTo(170)
        }
        loginView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }

        formStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        titleStack.snp.makeConstraints { make in
            make.bottom.equalTo(formStack.snp.top).offset(-50)
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalToSuperview()
        }
        signUpStack.snp.makeConstraints { make in
            make.bottom.equalTo(loginView.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc
    func signUpButtonIsPressed(){
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
