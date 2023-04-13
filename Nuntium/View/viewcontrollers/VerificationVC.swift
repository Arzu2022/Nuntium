//
//  Verification.swift
//  Nuntium
//
//  Created by AziK's  MAC on 13.04.23.
//

import UIKit

class VerificationVC: BaseViewController<VerificationViewModel> {
    
    private lazy var mainLabel:UILabel = {
        let text = UILabel()
        text.text = "Verification Code ✅"
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return text
    }()
    private lazy var secondLabel:UILabel = {
        let text = UILabel()
        text.text = "You need to enter 4-digit code we send to your email adress."
        text.textColor = UIColor(named:"Grey")
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return text
    }()
    private lazy var verficitionNum1TextField:UITextField = {
        let tf = UITextField()
        tf.autocorrectionType = .no
        tf.layer.cornerRadius = 8
        tf.textAlignment = .center
        tf.delegate = self
        tf.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        tf.backgroundColor = UIColor(named: "textfield")
        tf.keyboardType = .numberPad
        tf.placeholder = "-"
        return tf
    }()
    private lazy var verficitionNum2TextField:UITextField = {
        let tf = UITextField()
        tf.autocorrectionType = .no
        tf.layer.cornerRadius = 8
        tf.textAlignment = .center
        tf.delegate = self
        tf.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        tf.backgroundColor = UIColor(named: "textfield")
        tf.keyboardType = .numberPad
        tf.placeholder = "-"
        return tf
    }()
    private lazy var verficitionNum3TextField:UITextField = {
        let tf = UITextField()
        tf.autocorrectionType = .no
        tf.layer.cornerRadius = 8
        tf.textAlignment = .center
        tf.delegate = self
        tf.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        tf.backgroundColor = UIColor(named: "textfield")
        tf.keyboardType = .numberPad
        tf.placeholder = "-"
        return tf
    }()
    private lazy var verficitionNum4TextField:UITextField = {
        let tf = UITextField()
        tf.autocorrectionType = .no
        tf.layer.cornerRadius = 8
        tf.textAlignment = .center
        tf.delegate = self
        tf.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        tf.backgroundColor = UIColor(named: "textfield")
        tf.keyboardType = .numberPad
        tf.placeholder = "-"
        return tf
    }()
    private lazy var confirmBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Confirm", for: .normal)
        btn.backgroundColor = UIColor(named: "PurpleC")
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(onClickConfirmBtn), for: .touchUpInside)
        return btn
    }()
    private lazy var accountLabel:UILabel = {
        let text = UILabel()
        text.text = "Didn’t receive an email?"
        text.textColor = UIColor(named: "Grey")
        text.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return text
    }()
    private lazy var sendAgainBtn:UILabel = {
        let text = UILabel()
        let tap = UITapGestureRecognizer(target: self, action: #selector(onClickSendAgain(_ :)))
        text.addGestureRecognizer(tap)
        text.isUserInteractionEnabled = true
        text.text = "Send again"
        text.textColor = UIColor(named: "Grey")
        text.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return text
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    //MARK: FUNCTIONS
    private func setup(){
        self.view.backgroundColor = .white
        self.view.addSubview(mainLabel)
        self.view.addSubview(secondLabel)
        self.view.addSubview(accountLabel)
        self.view.addSubview(sendAgainBtn)
        self.view.addSubview(confirmBtn)
        self.view.addSubview(verficitionNum2TextField)
        self.view.addSubview(verficitionNum1TextField)
        self.view.addSubview(verficitionNum3TextField)
        self.view.addSubview(verficitionNum4TextField)
        
        mainLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        secondLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(mainLabel.snp.bottom).offset(8)
        }
        verficitionNum1TextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(screenWidth*0.04)
            make.top.equalTo(secondLabel.snp.bottom).offset(30)
            make.width.height.equalTo(screenWidth*0.2)
        }
        verficitionNum4TextField.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-screenWidth*0.04)
            make.top.equalTo(secondLabel.snp.bottom).offset(30)
            make.width.height.equalTo(screenWidth*0.2)
        }
        verficitionNum2TextField.snp.makeConstraints { make in
            make.left.equalTo(verficitionNum1TextField.snp.right).offset(screenWidth*0.04)
            make.top.equalTo(secondLabel.snp.bottom).offset(30)
            make.width.height.equalTo(screenWidth*0.2)
        }
        verficitionNum3TextField.snp.makeConstraints { make in
            make.left.equalTo(verficitionNum2TextField.snp.right).offset(screenWidth*0.04)
            make.top.equalTo(secondLabel.snp.bottom).offset(30)
            make.width.height.equalTo(screenWidth*0.2)
        }
        confirmBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(verficitionNum1TextField.snp.bottom).offset(16)
            make.height.equalTo(48)
        }
        accountLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-40)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        sendAgainBtn.snp.makeConstraints { make in
            make.left.equalTo(accountLabel.snp.right).offset(3)
            make.bottom.equalTo(accountLabel.snp.bottom)
        }
        
    }
    //MARK: UI FUNCTIONS
    @objc
    func onClickSendAgain(_ sender: UITapGestureRecognizer){
       // send again
    }
    @objc
    func onClickConfirmBtn(){
        navigationController?.viewControllers = [router.createNewPasswordVC()]
    }
}
extension VerificationVC:UITextFieldDelegate {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       if let _ = string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) {
           
//           switch textField {
//           case verficitionNum1TextField :
//               verficitionNum1TextField.text = textField.text ?? "" + string
//               verficitionNum2TextField.becomeFirstResponder()
//           case verficitionNum2TextField :
//               verficitionNum2TextField.text = textField.text ?? "" + string
//               verficitionNum3TextField.becomeFirstResponder()
//           case verficitionNum3TextField :
//               verficitionNum3TextField.text = textField.text ?? "" + string
//               verficitionNum4TextField.becomeFirstResponder()
//           default:
//               verficitionNum4TextField.text = textField.text ?? "" + string
//               verficitionNum4TextField.resignFirstResponder()
//           }
           return true
       } else {
          return false
       }
    }
        
}

