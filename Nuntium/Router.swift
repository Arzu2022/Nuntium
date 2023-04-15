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
    func languageVC() -> UIViewController
    func termsVC() -> UIViewController
    func aboutUsVC() -> UIViewController
    func changePasswordVC() -> UIViewController
}
public class Router:RouterProtocol {
    public func aboutUsVC() -> UIViewController {
        return AboutUsVC(vm: AboutUsVCViewModel(), router: self)
    }
    
    public func languageVC() -> UIViewController {
        return LanguageVC(vm: LanguageViewModel(), router: self)
    }
    
    public func termsVC() -> UIViewController {
        return TermsVC(vm: TermsViewModel(), router: self)
    }
    public func changePasswordVC() -> UIViewController {
        return ChangPasswordVC(vm: ChangePasswordViewModel(), router: self)
    }
    
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
