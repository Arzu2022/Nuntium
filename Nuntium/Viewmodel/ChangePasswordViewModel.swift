//
//  ChangePasswordViewModel.swift
//  Nuntium
//
//  Created by AziK's  MAC on 16.04.23.
//

import Foundation
import Promises

class ChangePasswordViewModel {
    var checkSecureCurrent:Bool = true
    var checkSecureNew:Bool = true
    var checkSecureRepeat:Bool = true
    let request = AuthRequest()
    func changePassword(with email:String) -> Promise<Result<Void,Error>> {
        let promise = Promise<Result<Void,Error>>.pending()
        request.updatePassword(with: email).then { result in
            promise.fulfill(result)
        }
        return promise
    }
}
