//
//  OnboardingLoginViewController.swift
//  Haloto
//
//  Created by Javier Fransiscus on 07/12/21.
//

import Foundation
import UIKit

class OnboardingLoginViewController: UIViewController {
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
        temp.setupView(formType: .empty)
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

    private lazy var buttonAddNewVehicle: UIButton = {
        let temp = UIButton()

        return temp
    }()

    private let viewModel = OnboardingLoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }

    func bindViewModel() {
        let output = viewModel.transform(input: .init(tapAddVehicle: buttonAddNewVehicle.rx.tap.asDriver()))

        output.vehicleDidTapped
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                let vc = AddNewVehicleViewController(vehicle: nil, type: .add)
                self.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: rx.disposeBag)
    }
}

private extension OnboardingLoginViewController {
    func setupView() {
        view.addSubview(loginView)
        loginView.addSubview(backgroundImageView)
        loginView.addSubview(formCard)
        loginView.addSubview(titleStack)
        loginView.addSubview(buttonAddNewVehicle)

        formCard.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
            make.height.equalTo(Double(self.view.frame.height) * 0.6)
        }
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        iconImageView.snp.makeConstraints { make in
            make.height.width.equalTo(125)
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

        buttonAddNewVehicle.snp.makeConstraints { make in
            make.edges.equalTo(formCard.onboardingImageView)
        }
    }
}
