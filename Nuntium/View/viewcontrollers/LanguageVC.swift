//
//  LanguageVC.swift
//  Nuntium
//
//  Created by AziK's  MAC on 16.04.23.
//

import UIKit

class LanguageVC: BaseViewController<LanguageViewModel> {

    private lazy var englishLanBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("English", for: .normal)
        btn.backgroundColor = UIColor(named: "PurpleC")
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(onClickEnglish), for: .touchUpInside)
        btn.addSubview(checkBtn)
        checkBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-24)
        }
        return btn
    }()
    private lazy var azeirbaijanLanBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Azerbaijan", for: .normal)
        btn.setTitleColor(UIColor(named: "Grey"), for: .normal)
        btn.backgroundColor = UIColor(named: "textfield")
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(onClickAZE), for: .touchUpInside)
        return btn
    }()
    private lazy var russionLanBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Russion", for: .normal)
        btn.setTitleColor(UIColor(named: "Grey"), for: .normal)
        btn.backgroundColor = UIColor(named: "textfield")
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(onClickRussion), for: .touchUpInside)
        return btn
    }()
    private lazy var checkBtn:UIImageView = {
       let icon = UIImageView(image: UIImage(named: "checkBtn"))
        return icon
    }()
    // MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    // MARK: - FUNCTIONS
    private func setup(){
        self.view.backgroundColor = .white
        self.title = "Language"
        self.view.addSubview(englishLanBtn)
        self.view.addSubview(azeirbaijanLanBtn)
        self.view.addSubview(russionLanBtn)
        englishLanBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(16)
            make.height.equalTo(48)
        }
        azeirbaijanLanBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(englishLanBtn.snp.bottom).offset(16)
            make.height.equalTo(48)
        }
        russionLanBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(azeirbaijanLanBtn.snp.bottom).offset(16)
            make.height.equalTo(48)
        }
    }
    // MARK: - UIFUNCTIONS
    @objc
    func onClickEnglish(){
        checkBtn.removeFromSuperview()
        azeirbaijanLanBtn.backgroundColor = UIColor(named: "textfield")
        russionLanBtn.backgroundColor = UIColor(named: "textfield")
        englishLanBtn.backgroundColor = UIColor(named: "PurpleC")
        
        englishLanBtn.setTitleColor(UIColor.white, for: .normal)
        russionLanBtn.setTitleColor(UIColor(named: "Grey"), for: .normal)
        azeirbaijanLanBtn.setTitleColor(UIColor(named: "Grey"), for: .normal)
        vm.language = "English"
        englishLanBtn.addSubview(checkBtn)
        checkBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-24)
        }
    }
    @objc
    func onClickAZE(){
        checkBtn.removeFromSuperview()
        englishLanBtn.backgroundColor = UIColor(named: "textfield")
        russionLanBtn.backgroundColor = UIColor(named: "textfield")
        azeirbaijanLanBtn.backgroundColor = UIColor(named: "PurpleC")
        vm.language = "Azerbaijan"
        azeirbaijanLanBtn.setTitleColor(UIColor.white, for: .normal)
        russionLanBtn.setTitleColor(UIColor(named: "Grey"), for: .normal)
        englishLanBtn.setTitleColor(UIColor(named: "Grey"), for: .normal)
        
        azeirbaijanLanBtn.addSubview(checkBtn)
        checkBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-24)
        }
    }
    @objc
    func onClickRussion(){
        checkBtn.removeFromSuperview()
        azeirbaijanLanBtn.backgroundColor = UIColor(named: "textfield")
        englishLanBtn.backgroundColor = UIColor(named: "textfield")
        russionLanBtn.backgroundColor = UIColor(named: "PurpleC")
        vm.language = "Russian"
        russionLanBtn.setTitleColor(UIColor.white, for: .normal)
        englishLanBtn.setTitleColor(UIColor(named: "Grey"), for: .normal)
        azeirbaijanLanBtn.setTitleColor(UIColor(named: "Grey"), for: .normal)
        
        russionLanBtn.addSubview(checkBtn)
        checkBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-24)
        }
    }
}
