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
        contentView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
        icon.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(300)
        }
    }
    
}
