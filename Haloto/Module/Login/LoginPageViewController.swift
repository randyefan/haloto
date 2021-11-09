//
//  LoginPageViewController.swift
//  Haloto
//
//  Created by Javier Fransiscus on 05/11/21.
//

import UIKit
import SnapKit

class LoginPageViewController: UIViewController {
    @IBOutlet weak var loginView: UIView!
    
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

    private lazy var titleStack: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [titleNameImage, iconImageView])
        temp.axis = .vertical
        temp.spacing = 12
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


fileprivate extension LoginPageViewController{
    func setupView(){
        view.addSubview(titleStack)
        iconImageView.snp.makeConstraints { make in
            make.height.equalTo(125)
            make.width.equalTo(125)
            make.centerY.equalTo(loginView.snp.top)
        }
        titleNameImage.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.width.equalTo(125)
            
        }
        titleStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
        
        loginView.snp.makeConstraints { make in
            make.height.equalTo((Double(self.view.frame.height)) * 0.6)
        }
    }
}
