//
//  ChangPasswordVC.swift
//  Nuntium
//
//  Created by AziK's  MAC on 16.04.23.
//

import UIKit

class ChangPasswordVC: BaseViewController<ChangePasswordViewModel> {
    private lazy var checkSecureCurrentPasswordBtn:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "eye")!, for: .normal)
        btn.addTarget(self, action: #selector(onClickShowCurrentPassword), for: .touchUpInside)
        return btn
    }()
    private lazy var checkSecureNewPasswordBtn:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "eye")!, for: .normal)
        btn.addTarget(self, action: #selector(onClickShowNewPassword), for: .touchUpInside)
        return btn
    }()
    private lazy var checkSecureRepeatPasswordBtn:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "eye")!, for: .normal)
        btn.addTarget(self, action: #selector(onClickShowRepeatPassword), for: .touchUpInside)
        return btn
    }()
    private lazy var checkCurrentPasswordImage:UIImageView = {
        let image = UIImageView(image: UIImage(named: "password"))
        return image
    }()
    private lazy var checkNewPasswordImage:UIImageView = {
        let image = UIImageView(image: UIImage(named: "password"))
        return image
    }()
    private lazy var checkRepeatPasswordImage:UIImageView = {
        let image = UIImageView(image: UIImage(named: "password"))
        return image
    }()
    private lazy var currentPasswordTextField:UITextField = {
        let tf = UITextField()
        tf.autocorrectionType = .no
        tf.makeIcon(imageV: checkCurrentPasswordImage)
        tf.setLeftPaddingPoints(40)
        tf.layer.cornerRadius = 8
        tf.delegate = self
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(named: "textfield")
        tf.placeholder = "Current Password"
        return tf
    }()
    private lazy var newPasswordTextField:UITextField = {
        let tf = UITextField()
        tf.autocorrectionType = .no
        tf.makeIcon(imageV: checkNewPasswordImage)
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
    private lazy var changePasswordBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Change Password", for: .normal)
        btn.backgroundColor = UIColor(named: "PurpleC")
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(onClickChange), for: .touchUpInside)
        return btn
    }()
    // MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    // MARK: - FUNCTIONS
    private func changeTexfieldColor(textField:UITextField){
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: "PurpleC")?.cgColor
        if textField == newPasswordTextField {
            checkNewPasswordImage.image = UIImage(named: "passwordBlue")!
            textField.addSubview(checkSecureNewPasswordBtn)
            checkSecureNewPasswordBtn.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(-15)
            }
        } else if textField == currentPasswordTextField {
            checkCurrentPasswordImage.image = UIImage(named: "passwordBlue")!
            textField.addSubview(checkSecureCurrentPasswordBtn)
            checkSecureCurrentPasswordBtn.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(-15)
            }
        }else {
            checkRepeatPasswordImage.image = UIImage(named: "passwordBlue")!
            textField.addSubview(checkSecureRepeatPasswordBtn)
            checkSecureRepeatPasswordBtn.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(-15)
            }
        }
    }
    private func setup(){
        self.view.backgroundColor = .white
        self.title = "Change Password"
        self.view.addSubview(currentPasswordTextField)
        self.view.addSubview(changePasswordBtn)
        self.view.addSubview(newPasswordTextField)
        self.view.addSubview(repeatPasswordTextField)
        self.navigationController?.navigationBar.tintColor = UIColor(named: "PurpleC")

        currentPasswordTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(16)
            make.height.equalTo(48)
        }
        newPasswordTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(currentPasswordTextField.snp.bottom).offset(16)
            make.height.equalTo(48)
        }
        repeatPasswordTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(newPasswordTextField.snp.bottom).offset(16)
            make.height.equalTo(48)
        }
        changePasswordBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(repeatPasswordTextField.snp.bottom).offset(16)
            make.height.equalTo(48)
        }
    }
    // MARK: - UIFUNCTIONS
    
    @objc
    func onClickChange(){
        if repeatPasswordTextField.text != "" && currentPasswordTextField.text != "" && newPasswordTextField.text != "" {
            if repeatPasswordTextField.text == newPasswordTextField.text {
                if currentPasswordTextField.text != self.userDefaults.string(forKey: "password") {
                    self.showAlert(message: "Current password is not correct!!", error: true)
                } else {
                    self.vm.changePassword(with: repeatPasswordTextField.text!).then { result in
                        switch result {
                        case .failure(let err):
                            self.showAlert(message: err.localizedDescription, error: true)
                        case .success(()):
                            self.navigationController?.viewControllers = [self.router.loginVC()]
                        }
                    }
                }} else {
                self.showAlert(message: "New password is not equal to Repeat password", error: true)
            }
        } else {
            self.showAlert(message: "Please, fill of them", error: true)
        }
    }
    @objc
    func onClickShowCurrentPassword(){
        if vm.checkSecureCurrent {
            vm.checkSecureCurrent = false
            currentPasswordTextField.isSecureTextEntry = false
        } else {
            vm.checkSecureCurrent = true
            currentPasswordTextField.isSecureTextEntry = true
        }
    }
    @objc
    func onClickShowNewPassword(){
        if vm.checkSecureNew {
            vm.checkSecureNew = false
            newPasswordTextField.isSecureTextEntry = false
        } else {
            vm.checkSecureNew = true
            newPasswordTextField.isSecureTextEntry = true
        }
    }
    @objc
    func onClickShowRepeatPassword(){
        if vm.checkSecureRepeat {
            vm.checkSecureRepeat = false
            repeatPasswordTextField.isSecureTextEntry = false
        } else {
            vm.checkSecureRepeat = true
            repeatPasswordTextField.isSecureTextEntry = true
        }
    }
}
extension ChangPasswordVC:UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == newPasswordTextField {
            changeTexfieldColor(textField: newPasswordTextField)
        } else if textField == repeatPasswordTextField  {
            changeTexfieldColor(textField: repeatPasswordTextField)
        } else {
            changeTexfieldColor(textField: currentPasswordTextField)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
