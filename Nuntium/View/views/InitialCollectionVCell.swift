//
//  InitialCollectionVCell.swift
//  Nuntium
//
//  Created by AziK's  MAC on 12.04.23.
//

import Foundation
import UIKit
import SnapKit
class InitialCollectionVCell:UICollectionViewCell {
    lazy var icon:UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 16
        image.layer.masksToBounds = true
        return image
    }()
        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setup()
        }
    private func setup() {
        contentView.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(300)
            make.width.equalTo(250)
        }
    }
    
}
