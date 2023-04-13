//
//  Router.swift
//  Nuntium
//
//  Created by AziK's  MAC on 12.04.23.
//

import UIKit
public protocol RouterProtocol {
    func homeVC() -> UIViewController
    func initialVC() -> UIViewController
    func getStartedVC() -> UIViewController
    func loginVC() -> UIViewController
    func forgotPassword() -> UIViewController
    func verificationVC() -> UIViewController
}
public class Router:RouterProtocol {
    public func verificationVC() -> UIViewController {
        return VerificationVC(vm: VerificationViewModel(), router: self)
    }
    
    public func forgotPassword() -> UIViewController {
        return ForgotPasswordVC(vm: ForgotPasswordViewModel(), router: self)
    }
    
    public func loginVC() -> UIViewController {
        return LoginVC(vm: LoginViewModel(), router: self)
    }
    
    public func initialVC() -> UIViewController {
        return InitalVC(vm: InitialViewModel(), router: self)
    }
    
    public func getStartedVC() -> UIViewController {
        return GetStartedVC(vm: GetStartedViewModel(), router: self)
    }
    
    public func homeVC() -> UIViewController {
        return HomeVC(vm: HomeViewModel(), router: self)
    }
    
}
