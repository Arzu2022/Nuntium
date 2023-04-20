//
//  LoginViewModel.swift
//  Nuntium
//
//  Created by AziK's  MAC on 13.04.23.
//

import Foundation
import Promises
import UIKit
class LoginViewModel {
    var checkSecure:Bool = true
    let request = AuthRequest()
    func isLogin(with email:String,with password:String)-> Promise<Result<Void,Error>> {
        let promise = Promise<Result<Void,Error>>.pending()
        request.login(with: email, with: password).then { result in
            promise.fulfill(result)
        }
        return promise
    }
    func googleSignIn(vc:UIViewController) -> Promise<Result<Void,Error>>{
        let promise = Promise<Result<Void,Error>>.pending()
        request.signInGoogle(vc: vc).then { result in
            promise.fulfill(result)
        }
        return promise
    }
    
}
