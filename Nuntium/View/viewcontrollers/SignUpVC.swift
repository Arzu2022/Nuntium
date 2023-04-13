//
//  SignUpVC.swift
//  Nuntium
//
//  Created by AziK's  MAC on 13.04.23.
//

import UIKit

class SignUpVC: BaseViewController<SignUpViewModel> {
    private lazy var mainLabel:UILabel = {
        let text = UILabel()
        text.text = "Welcome to Nuntium 👋"
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return text
    }()
    private lazy var secondLabel:UILabel = {
        let text = UILabel()
        text.text = "Hello, I guess you are new around here. You can start using the application after sign up."
        text.textColor = UIColor(named:"Grey")
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return text
    }()
    private lazy var checkMailImage:UIImageView = {
        let image = UIImageView(image: UIImage(named: "mail"))
        return image
    }()
    private lazy var checkUserImage:UIImageView = {
        let image = UIImageView(image: UIImage(named: "user"))
        return image
    }()
    private lazy var checkPasswordImage:UIImageView = {
        let image = UIImageView(image: UIImage(named: "password"))
        return image
    }()
    private lazy var checkRepeatPasswordImage:UIImageView = {
        let image = UIImageView(image: UIImage(named: "password"))
        return image
    }()
    
    private lazy var checkSecurePasswordBtn:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "eye")!, for: .normal)
        btn.addTarget(self, action: #selector(onClickShowPassword), for: .touchUpInside)
        return btn
    }()
    private lazy var checkSecureRepeatPasswordBtn:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "eye")!, for: .normal)
        btn.addTarget(self, action: #selector(onClickShowPassword), for: .touchUpInside)
        return btn
    }()
    
    private lazy var userTextField:UITextField = {
        let tf = UITextField()
        tf.autocorrectionType = .no
        tf.makeIcon(imageV: checkUserImage)
        tf.setLeftPaddingPoints(40)
        tf.layer.cornerRadius = 8
        tf.delegate = self
        tf.backgroundColor = UIColor(named: "textfield")
        tf.placeholder = "User"
        return tf
    }()
    private lazy var mailTextField:UITextField = {
        let tf = UITextField()
        tf.autocorrectionType = .no
        tf.makeIcon(imageV: checkMailImage)
        tf.setLeftPaddingPoints(40)
        tf.layer.cornerRadius = 8
        tf.delegate = self
        tf.backgroundColor = UIColor(named: "textfield")
        tf.placeholder = "Email Adress"
        return tf
    }()
    
    private lazy var passwordTextField:UITextField = {
        let tf = UITextField()
        tf.autocorrectionType = .no
        tf.makeIcon(imageV: checkPasswordImage)
        tf.setLeftPaddingPoints(40)
        tf.layer.cornerRadius = 8
        tf.delegate = self
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(named: "textfield")
        tf.placeholder = "Password"
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
        tf.placeholder = "Repeat Password"
        return tf
    }()
    private lazy var accountLabel:UILabel = {
        let text = UILabel()
        text.text = "Already have an account?"
        text.textColor = UIColor(named: "Grey")
        text.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return text
    }()
    private lazy var loginBtn:UILabel = {
        let text = UILabel()
        let tap = UITapGestureRecognizer(target: self, action: #selector(onClickLogin(_ :)))
        text.addGestureRecognizer(tap)
        text.isUserInteractionEnabled = true
        text.text = "Sign In"
        text.textColor = UIColor(named: "Grey")
        text.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return text
    }()
    private lazy var signUpBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign Up", for: .normal)
        btn.backgroundColor = UIColor(named: "PurpleC")
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(onClickSignup), for: .touchUpInside)
        return btn
    }()
    //MARK: VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    //MARK: FUNCTIONS
    private func setup(){
        self.view.backgroundColor = .white
        self.view.addSubview(mainLabel)
        self.view.addSubview(secondLabel)
        self.view.addSubview(mailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(userTextField)
        self.view.addSubview(repeatPasswordTextField)
        self.view.addSubview(accountLabel)
        self.view.addSubview(loginBtn)
        self.view.addSubview(signUpBtn)
        
        mainLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        secondLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(mainLabel.snp.bottom).offset(8)
        }
        userTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(secondLabel.snp.bottom).offset(30)
            make.height.equalTo(48)
        }
        mailTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(userTextField.snp.bottom).offset(20)
            make.height.equalTo(48)
        }
        passwordTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(mailTextField.snp.bottom).offset(20)
            make.height.equalTo(48)
        }
        repeatPasswordTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.height.equalTo(48)
        }
        signUpBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(repeatPasswordTextField.snp.bottom).offset(16)
            make.height.equalTo(48)
        }
        accountLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-40)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        loginBtn.snp.makeConstraints { make in
            make.left.equalTo(accountLabel.snp.right).offset(3)
            make.bottom.equalTo(accountLabel.snp.bottom)
        }
        
        
    }
    
    //MARK: UIFUNCTIONS
    @objc
    func onClickShowPassword(type:UIButton){
        if type == checkSecurePasswordBtn {
            if vm.checkSecurePassword {
                vm.checkSecurePassword = false
                passwordTextField.isSecureTextEntry = false
            } else {
                vm.checkSecurePassword = true
                passwordTextField.isSecureTextEntry = true
            }
        } else {
            if vm.checkSecureRepeatPassword {
                vm.checkSecureRepeatPassword = false
                repeatPasswordTextField.isSecureTextEntry = false
            } else {
                vm.checkSecureRepeatPassword = true
                repeatPasswordTextField.isSecureTextEntry = true
            }
        }
        
    }
    @objc
    func onClickLogin(_ sender: UITapGestureRecognizer){
        navigationController?.viewControllers = [router.loginVC()]
    }
    @objc
    func onClickSignup(){
        //firebase
        navigationController?.viewControllers = [router.favoriteVC()]
    }
}
extension SignUpVC:UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: "PurpleC")?.cgColor
        if textField == userTextField {
            checkUserImage.image = UIImage(named: "userBlue")
        } else if textField == mailTextField {
            checkMailImage.image = UIImage(named: "mailBlue")!
        } else if textField == passwordTextField {
            checkPasswordImage.image = UIImage(named: "passwordBlue")!
            textField.addSubview(checkSecurePasswordBtn)
            checkSecurePasswordBtn.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(-15)
            }
        } else if textField == repeatPasswordTextField {
            checkRepeatPasswordImage.image = UIImage(named: "passwordBlue")!
            textField.addSubview(checkSecureRepeatPasswordBtn)
            checkSecureRepeatPasswordBtn.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(-15)
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            if textField == userTextField {
                vm.user = text
            } else if textField == mailTextField {
                vm.mail = text
            } else if textField == passwordTextField {
                vm.password = text
            } else if textField == repeatPasswordTextField {
                vm.repeatPassword = text
            }
        }
        textField.resignFirstResponder()
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            if textField == userTextField {
                vm.user = text
            } else if textField == mailTextField {
                vm.mail = text
            } else if textField == passwordTextField {
                vm.password = text
            } else if textField == repeatPasswordTextField {
                vm.repeatPassword = text
            }
        }
        textField.resignFirstResponder()
        return true
    }
}

