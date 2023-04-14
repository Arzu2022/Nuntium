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
    func createNewPasswordVC() -> UIViewController
    func signupVC() -> UIViewController
    func favoriteVC() -> UIViewController
    func categoryVC() -> UIViewController
    func bookmarkVC() -> UIViewController
    func profileVC() -> UIViewController
}
public class Router:RouterProtocol {
    public func categoryVC() -> UIViewController {
        return CategoryVC(vm: CategoryViewModel(), router: self)
    }
    
    public func bookmarkVC() -> UIViewController {
        return BookmarkVC(vm: BookmarkViewModel(), router: self)
    }
    
    public func profileVC() -> UIViewController {
        return ProfileVC(vm: ProfileViewModel(), router: self)
    }
    
    public func favoriteVC() -> UIViewController {
        return FavoriteTopicVC(vm: FavoriteTopicViewModel(), router: self)
    }
    public func signupVC() -> UIViewController {
        return SignUpVC(vm: SignUpViewModel(), router: self)
    }
    public func createNewPasswordVC() -> UIViewController {
        return CreateNewPasswordVC(vm: CreateNewPasswordViewModel(), router: self)
    }
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
