//
//  ProfileViewModel.swift
//  Nuntium
//
//  Created by AziK's  MAC on 15.04.23.
//

import Foundation
import UIKit
import Promises

class ProfileViewModel {
    let request = AuthRequest()
    let stoageRequest = StorageRequest()
    var fullName : String = ""
    var gmail: String = ""
    var profileImage = UIImage(named: "test")
    var data:[ProfileCVModel] = [
        ProfileCVModel(title: "Notifications", icon: UIImage(named: "right")!),
        ProfileCVModel(title: "Language", icon: UIImage(named: "right")!),
        ProfileCVModel(title: "Change Password", icon: UIImage(named: "right")!),
        ProfileCVModel(title: "Terms & Conditions", icon: UIImage(named: "right")!),
        ProfileCVModel(title: "About", icon: UIImage(named: "right")!),
        ProfileCVModel(title: "Sign Out", icon: UIImage(named: "signout")!)
    ]
    var checkSwitch:Bool = false
    init(){
        self.fullName = request.name ?? "no name"
        self.gmail = request.email ?? "no gmail"
    }
    func signout()-> Promise<Result<Void,Error>>{
        let promise = Promise<Result<Void,Error>>.pending()
        request.signout().then { result in
            promise.fulfill(result)
        }
        return promise
    }
    func deleteUser() -> Promise<Result<Void,Error>> {
        let promise = Promise<Result<Void,Error>>.pending()
        request.deleteUser().then({ result in
            promise.fulfill(result)
        })
        return promise
    }
    func addOrUpdateProfilePhoto(data:Data) -> Promise<Result<Void,Error>>{
        let promise = Promise<Result<Void,Error>>.pending()
        stoageRequest.addOrUpdateProfilePhoto(with: data).then { result in
            promise.fulfill(result)
        }
        return promise
    }
}
