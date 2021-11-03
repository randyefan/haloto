//
//  MainButton.swift
//  Haloto
//
//  Created by Javier Fransiscus on 03/11/21.
//

import UIKit
import SnapKit

class LoginButton: UIButton {
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        setupButton()
    }
    
    
    func setTitle(title: String){
        
        self.setAttributedTitle(.font("\(title)", size: 11, fontWeight: .medium, color: UIColor(hexString: "2D2D2D"), alignment: .center, underline: false, isTitle: false), for: .normal)
    }

}


fileprivate extension LoginButton{
    func setupButton(){
        self.backgroundColor = UIColor(named: "button-yellow")
        self.cornerRadius = 22
        self.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(172)
        }
        
    }
}

