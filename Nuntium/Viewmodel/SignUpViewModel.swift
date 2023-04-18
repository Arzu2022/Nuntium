//
//  SignUpViewModel.swift
//  Nuntium
//
//  Created by AziK's  MAC on 13.04.23.
//

import Foundation
import Promises
class SignUpViewModel {
    var user:String = ""
    var mail:String = ""
    var password:String = ""
    var repeatPassword:String = ""
    var checkSecurePassword:Bool = true
    var checkSecureRepeatPassword:Bool = true
    let request = AuthRequest()
    
    func isSigup(with email:String, with password:String,username:String) -> Promise<Result<Void,Error>>{
        let promise = Promise<Result<Void,Error>>.pending()
        request.signUp(with: email, with: password,username: username).then { result in
            promise.fulfill(result)
        }
        return promise
    }
}
