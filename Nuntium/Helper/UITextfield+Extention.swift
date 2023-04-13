//
//  UITextfieldExtention.swift
//  Nuntium
//
//  Created by AziK's  MAC on 13.04.23.
//

import Foundation
import SnapKit
import UIKit
extension UITextField {
   
       func setLeftPaddingPoints(_ amount:CGFloat){
           let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
           self.leftView = paddingView
           self.leftViewMode = .always
       }
       func setRightPaddingPoints(_ amount:CGFloat) {
           let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
           self.rightView = paddingView
           self.rightViewMode = .always
       }
    func makeIcon(imageV:UIImageView){
        self.addSubview(imageV)
        imageV.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
    }
}
