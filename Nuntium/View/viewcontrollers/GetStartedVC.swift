//
//  GetStartedVC.swift
//  Nuntium
//
//  Created by AziK's  MAC on 12.04.23.
//

import UIKit
import SnapKit

class GetStartedVC: BaseViewController<GetStartedViewModel> {

    private lazy var startBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Get Started", for: .normal)
        btn.backgroundColor = UIColor(named: "PurpleC")
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(onClickStart), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    //MARK: FUNCTIONS
    private func setup(){
        let image = UIImageView(image: UIImage(named: "3dillustration"))
        image.layer.cornerRadius = 16
        image.layer.masksToBounds = true
        
        let mainLabel = UILabel()
        mainLabel.text = "Nuntium"
        mainLabel.textColor = .black
        mainLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        
        let secondLabel = UILabel()
        secondLabel.text = "All news in one place, be the first to know last news"
        secondLabel.textColor = UIColor(named:"Grey")
        secondLabel.numberOfLines = 0
        secondLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        
        self.view.backgroundColor = .white
        self.view.addSubview(image)
        self.view.addSubview(mainLabel)
        self.view.addSubview(secondLabel)
        self.view.addSubview(startBtn)
        image.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.height.equalTo(300)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(image.snp.bottom).offset(60)
        }
        secondLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(75)
            make.right.equalToSuperview().offset(-70)
            make.top.equalTo(mainLabel.snp.bottom).offset(24)
        }
        startBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-40)
            make.height.equalTo(48)
        }
    }
    //MARK: UIFUNCTIONS
    @objc func onClickStart(){
        navigationController?.viewControllers = [router.loginVC()]
    }

}
