//
//  ProfileViewModel.swift
//  Nuntium
//
//  Created by AziK's  MAC on 15.04.23.
//

import Foundation
import UIKit
class ProfileViewModel {
    var fullName = "Arzu Heydarov"
    var gmail = "aheydarov@gmail.com"
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

}
