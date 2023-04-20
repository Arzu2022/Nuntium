//
//  LoginVC.swift
//  Nuntium
//
//  Created by AziK's  MAC on 13.04.23.
//

import UIKit
import SnapKit

class LoginVC: BaseViewController<LoginViewModel> {
    // MARK: CLOSURES
    private lazy var checkSecurePasswordBtn:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "eye")!, for: .normal)
        btn.addTarget(self, action: #selector(onClickShowPassword), for: .touchUpInside)
        return btn
    }()
    private lazy var checkMailImage:UIImageView = {
        let image = UIImageView(image: UIImage(named: "mail"))
        return image
    }()
    private lazy var checkPasswordImage:UIImageView = {
        let image = UIImageView(image: UIImage(named: "password"))
        return image
    }()
    private lazy var mainLabel:UILabel = {
        let text = UILabel()
        text.text = "Welcome Back 👋"
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return text
    }()
    private lazy var secondLabel:UILabel = {
        let text = UILabel()
        text.text = "I am happy to see you again. You can continue where you left off by logging in"
        text.textColor = UIColor(named:"Grey")
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return text
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
    private lazy var forgotPasswordBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Forgot Password?", for: .normal)
        btn.setTitleColor(UIColor(named: "Grey"), for: .normal)
        btn.addTarget(self, action: #selector(onClickForgotBtn), for: .touchUpInside)
        return btn
    }()
    private lazy var loginBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign In", for: .normal)
        btn.backgroundColor = UIColor(named: "PurpleC")
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(onClickLoginBtn), for: .touchUpInside)
        return btn
    }()
    private lazy var orLabel:UILabel = {
        let text = UILabel()
        text.text = "OR"
        text.textColor = UIColor(named: "Grey")
        text.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return text
    }()
    private lazy var googleLoginBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign In with Google", for: .normal)
        btn.setTitleColor(UIColor(named: "Grey"), for: .normal)
        btn.backgroundColor = .white
        btn.addIconInside(icon: UIImage(named: "google-logo")!)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor(white: 0.8, alpha: 0.4).cgColor
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(onClickGoogleLoginBtn), for: .touchUpInside)
        return btn
    }()
    private lazy var facebookLoginBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign In with Facebook", for: .normal)
        btn.setTitleColor(UIColor(named: "Grey"), for: .normal)
        btn.backgroundColor = .white
        btn.addIconInside(icon: UIImage(named: "facebook-logo")!)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor(white: 0.8, alpha: 0.4).cgColor
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(onClickFaceBookLoginBtn), for: .touchUpInside)
        return btn
    }()
    private lazy var accountLabel:UILabel = {
        let text = UILabel()
        text.text = "Don't have an account?"
        text.textColor = UIColor(named: "Grey")
        text.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return text
    }()
    private lazy var signupBtn:UILabel = {
        let text = UILabel()
        let tap = UITapGestureRecognizer(target: self, action: #selector(onClickSignUp(_ :)))
        text.addGestureRecognizer(tap)
        text.isUserInteractionEnabled = true
        text.text = "Sign Up"
        text.textColor = UIColor(named: "Grey")
        text.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return text
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    //MARK: FUNCTIONS
    private func changeTexfieldColor(textField:UITextField){
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: "PurpleC")?.cgColor
        if textField == mailTextField {
            checkMailImage.image = UIImage(named: "mailBlue")!
        } else {
            checkPasswordImage.image = UIImage(named: "passwordBlue")!
            textField.addSubview(checkSecurePasswordBtn)
            checkSecurePasswordBtn.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(-15)
            }
        }
        
    }
    private func setup(){
        
        self.view.backgroundColor = .white
        self.view.addSubview(mainLabel)
        self.view.addSubview(secondLabel)
        self.view.addSubview(mailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(forgotPasswordBtn)
        self.view.addSubview(loginBtn)
        self.view.addSubview(orLabel)
        self.view.addSubview(googleLoginBtn)
        self.view.addSubview(facebookLoginBtn)
        self.view.addSubview(accountLabel)
        self.view.addSubview(signupBtn)
        
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
            make.top.equalTo(secondLabel.snp.bottom).offset(20)
            make.height.equalTo(48)
        }
        passwordTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(mailTextField.snp.bottom).offset(20)
            make.height.equalTo(48)
        }
        forgotPasswordBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
        }
        loginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(forgotPasswordBtn.snp.bottom).offset(16)
            make.height.equalTo(48)
        }
        orLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginBtn.snp.bottom).offset(16)
        }
        googleLoginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(orLabel.snp.bottom).offset(16)
            make.height.equalTo(52)
        }
        facebookLoginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(googleLoginBtn.snp.bottom).offset(16)
            make.height.equalTo(52)
        }
        accountLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-40)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        signupBtn.snp.makeConstraints { make in
            make.left.equalTo(accountLabel.snp.right).offset(3)
            make.bottom.equalTo(accountLabel.snp.bottom)
        }
    }
    //MARK: UIFUNCTIONS
    @objc
    func onClickForgotBtn(){
        self.showToastForWait(message: "Please, check your mail for verification new password")
    }
    @objc
    func onClickLoginBtn(){
        if passwordTextField.text != "" && mailTextField.text != "" {
            vm.isLogin(with: mailTextField.text!, with: passwordTextField.text!).then({ result in
                switch result {
                case .success():
                    self.userDefaults.set("\(self.passwordTextField.text!)", forKey: "password")
                    self.navigationController?.viewControllers = [TabBar()]
                case .failure(let error):
                    self.showAlert(message: error.localizedDescription, error: true)
                }
            })
            }
        }
    @objc
    func onClickGoogleLoginBtn(){
        vm.googleSignIn(vc: self).then { result in
            switch result {
            case .success(()):
                self.navigationController?.viewControllers = [TabBar()]
            case .failure(let err):
                self.showAlert(message: err.localizedDescription, error: true)
            }
        }
    }
    @objc
    func onClickFaceBookLoginBtn(){
        self.showToast(message: "Next update)")
    }
    @objc
    func onClickSignUp(_ sender: UITapGestureRecognizer){
        navigationController?.viewControllers = [router.signupVC()]
    }
    @objc
    func onClickShowPassword(){
        if vm.checkSecure {
            vm.checkSecure = false
            passwordTextField.isSecureTextEntry = false
        } else {
            vm.checkSecure = true
            passwordTextField.isSecureTextEntry = true
        }
    }
}
extension LoginVC:UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == mailTextField{
                changeTexfieldColor(textField: mailTextField)
        }
        else if textField == passwordTextField {
                changeTexfieldColor(textField: passwordTextField)
        }
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
