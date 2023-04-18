//
//  LoginViewModel.swift
//  Nuntium
//
//  Created by AziK's  MAC on 13.04.23.
//

import Foundation
import Promises
class LoginViewModel {
    var mail:String = ""
    var password:String = ""
    var checkSecure:Bool = true
    let request = AuthRequest()
    func isLogin(with email:String,with password:String)-> Promise<Result<Void,Error>> {
        let promise = Promise<Result<Void,Error>>.pending()
        request.login(with: email, with: password).then { result in
            promise.fulfill(result)
        }
        return promise
    }
    
}
