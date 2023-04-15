//
//  ProfileCollectioVCell.swift
//  Nuntium
//
//  Created by AziK's  MAC on 16.04.23.
//

import Foundation
import UIKit
class ProfileCollectioVCell:UICollectionViewCell {
    lazy var title:UILabel = {
        let text = UILabel()
        text.textColor = UIColor(named: "Grey")
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return text
    }()
    lazy var button:UIButton = {
        let btn = UIButton()
        return btn
    }()
    lazy var switchButton:UISwitch = {
        let btn = UISwitch()
        btn.onTintColor = UIColor(named: "PurpleC")
        return btn
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func switchBtnsetup(){
        button.removeFromSuperview()
        contentView.addSubview(switchButton)
        switchButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24)
            make.centerY.equalToSuperview()
        }
    }
    private func setup(){
        contentView.addSubview(button)
        contentView.addSubview(title)
        contentView.layer.cornerRadius = 16
        contentView.backgroundColor = UIColor(named: "textfield")
        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.centerY.equalToSuperview()
        }
        button.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24)
            make.centerY.equalToSuperview()
        }
    }
}
