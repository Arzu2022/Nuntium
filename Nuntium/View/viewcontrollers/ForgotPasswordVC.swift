//
//  ForgotPassword.swift
//  Nuntium
//
//  Created by AziK's  MAC on 13.04.23.
//

import UIKit

class ForgotPasswordVC: BaseViewController<ForgotPasswordViewModel> {
    
    private lazy var mainLabel:UILabel = {
        let text = UILabel()
        text.text = "Forgot Password 🤔"
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return text
    }()
    private lazy var secondLabel:UILabel = {
        let text = UILabel()
        text.text = "We need your email adress so we can send you the password reset code."
        text.textColor = UIColor(named:"Grey")
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return text
    }()
    private lazy var checkMailImage:UIImageView = {
        let image = UIImageView(image: UIImage(named: "mail"))
        return image
    }()
    private lazy var mailTextField:UITextField = {
        let tf = UITextField()
        tf.autocorrectionType = .no
        tf.makeIcon(imageV: checkMailImage)
        tf.layer.cornerRadius = 8
        tf.delegate = self
        tf.setLeftPaddingPoints(40)
        tf.backgroundColor = UIColor(named: "textfield")
        tf.placeholder = "Email Adress"
        return tf
    }()
    private lazy var nextBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Next", for: .normal)
        btn.backgroundColor = UIColor(named: "PurpleC")
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(onClickNextBtn), for: .touchUpInside)
        return btn
    }()
    private lazy var accountLabel:UILabel = {
        let text = UILabel()
        text.text = "Remember the password?"
        text.textColor = UIColor(named: "Grey")
        text.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return text
    }()
    private lazy var backLoginBtn:UILabel = {
        let text = UILabel()
        let tap = UITapGestureRecognizer(target: self, action: #selector(onClickBackLogin(_ :)))
        text.addGestureRecognizer(tap)
        text.isUserInteractionEnabled = true
        text.text = "Try again"
        text.textColor = UIColor(named: "Grey")
        text.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return text
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    // MARK: FUNCTIONS
    private func changeTexfieldColor(textField:UITextField){
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: "PurpleC")?.cgColor
        checkMailImage.image = UIImage(named: "mailBlue")!
    }
    private func setup(){
        self.view.backgroundColor = .white
        self.view.addSubview(mainLabel)
        self.view.addSubview(secondLabel)
        self.view.addSubview(mailTextField)
        self.view.addSubview(accountLabel)
        self.view.addSubview(backLoginBtn)
        self.view.addSubview(nextBtn)
        
        mainLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        secondLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(mainLabel.snp.bottom).offset(8)
        }
        mailTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(secondLabel.snp.bottom).offset(40)
            make.height.equalTo(48)
        }
        nextBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(mailTextField.snp.bottom).offset(16)
            make.height.equalTo(48)
        }
        accountLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-40)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        backLoginBtn.snp.makeConstraints { make in
            make.left.equalTo(accountLabel.snp.right).offset(3)
            make.bottom.equalTo(accountLabel.snp.bottom)
        }
        
    }
    //MARK: UI-FUNCTIONS
    @objc
    func onClickBackLogin(_ sender: UITapGestureRecognizer){
        navigationController?.viewControllers = [router.loginVC()]
    }
    @objc
    func onClickNextBtn(){
        navigationController?.viewControllers = [router.verificationVC()]
    }
}
extension ForgotPasswordVC:UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        changeTexfieldColor(textField: mailTextField)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
                vm.mail = text
        }
        textField.resignFirstResponder()
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let text = textField.text {
                vm.mail = text
        }
        textField.resignFirstResponder()
        return true
    }
}
