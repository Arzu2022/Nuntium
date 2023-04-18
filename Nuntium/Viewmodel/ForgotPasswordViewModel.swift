//
//  ForgotPasswordViewModel.swift
//  Nuntium
//
//  Created by AziK's  MAC on 13.04.23.
//

import Foundation
import Promises
class ForgotPasswordViewModel {
    let request = AuthRequest()
    func sendLink(with email:String) -> Promise<Result<Void,Error>> {
        let promise = Promise<Result<Void,Error>>.pending()
        request.forgotPasswordViaMail(with: email).then { result in
            promise.fulfill(result)
        }
        return promise
    }
}
