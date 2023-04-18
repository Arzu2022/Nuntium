//
//  CreateNewPasswordVC.swift
//  Nuntium
//
//  Created by AziK's  MAC on 13.04.23.
//

import UIKit

class CreateNewPasswordVC: BaseViewController<CreateNewPasswordViewModel> {

    private lazy var mainLabel:UILabel = {
        let text = UILabel()
        text.text = "Create New Password 🔒"
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return text
    }()
    private lazy var secondLabel:UILabel = {
        let text = UILabel()
        text.text = "You can create a new password, please dont forget it too."
        text.textColor = UIColor(named:"Grey")
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return text
    }()
    private lazy var checkPasswordImage:UIImageView = {
        let image = UIImageView(image: UIImage(named: "password"))
        return image
    }()
    private lazy var checkRepeatPasswordImage:UIImageView = {
        let image = UIImageView(image: UIImage(named: "password"))
        return image
    }()
    private lazy var newPasswordTextField:UITextField = {
        let tf = UITextField()
        tf.autocorrectionType = .no
        tf.makeIcon(imageV: checkPasswordImage)
        tf.setLeftPaddingPoints(40)
        tf.layer.cornerRadius = 8
        tf.delegate = self
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(named: "textfield")
        tf.placeholder = "New Password"
        return tf
    }()
    private lazy var repeatPasswordTextField:UITextField = {
        let tf = UITextField()
        tf.autocorrectionType = .no
        tf.makeIcon(imageV: checkRepeatPasswordImage)
        tf.setLeftPaddingPoints(40)
        tf.layer.cornerRadius = 8
        tf.delegate = self
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(named: "textfield")
        tf.placeholder = "Repeat New Password"
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
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Functions
    private func changeTexfieldColor(textField:UITextField){
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: "PurpleC")?.cgColor
        if textField == newPasswordTextField {
            checkPasswordImage.image = UIImage(named: "passwordBlue")!
        } else {
            checkRepeatPasswordImage.image = UIImage(named: "passwordBlue")!
        }
    }
    private func setup(){
        self.view.backgroundColor = .white
        self.view.addSubview(mainLabel)
        self.view.addSubview(secondLabel)
        self.view.addSubview(confirmBtn)
        self.view.addSubview(newPasswordTextField)
        self.view.addSubview(repeatPasswordTextField)
        
        mainLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        secondLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(mainLabel.snp.bottom).offset(8)
        }
        newPasswordTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(secondLabel.snp.bottom).offset(40)
            make.height.equalTo(48)
        }
        repeatPasswordTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(newPasswordTextField.snp.bottom).offset(16)
            make.height.equalTo(48)
        }
        confirmBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(repeatPasswordTextField.snp.bottom).offset(16)
            make.height.equalTo(48)
        }
    }
    //  MARK: UIFUNCTIONS
    @objc
    func onClickConfirmBtn(){
        navigationController?.viewControllers = [router.loginVC()]
    }
}
extension CreateNewPasswordVC:UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == newPasswordTextField {
            changeTexfieldColor(textField: newPasswordTextField)
        } else if textField == repeatPasswordTextField  {
            changeTexfieldColor(textField: repeatPasswordTextField)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            if textField == newPasswordTextField {
                vm.newPassword = text
            } else {
                vm.repeatPassword = text
            }
        }
        textField.resignFirstResponder()
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            if textField == newPasswordTextField {
                vm.newPassword = text
            } else {
                vm.repeatPassword = text
            }
        }
        textField.resignFirstResponder()
        return true
    }
}
