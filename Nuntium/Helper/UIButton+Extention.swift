//
//  UIButton+Extention.swift
//  Nuntium
//
//  Created by AziK's  MAC on 13.04.23.
//

import Foundation
import SnapKit
import UIKit

extension UIButton {
    func addIconInside(icon:UIImage){
        let image = UIImageView(image: icon)
        self.addSubview(image)
        image.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
        }
    }
    
}
