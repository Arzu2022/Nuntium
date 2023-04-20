//
//  TopicCategryCollectionVCell.swift
//  Nuntium
//
//  Created by AziK's  MAC on 14.04.23.
//

import Foundation
import UIKit
import SnapKit

class TopicCategryCollectionVCell:UICollectionViewCell {
    lazy var title:UILabel = {
        let text = UILabel()
        text.textColor = .white
        text.numberOfLines = 3
        text.lineBreakMode = .byTruncatingTail
        text.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return text
    }()
    lazy var type:UILabel = {
        let text = UILabel()
        text.textColor = .white
        text.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return text
    }()
    lazy var image:UIImageView = {
        let icon = UIImageView()
        icon.layer.cornerRadius = 16
        icon.layer.masksToBounds = true
        return icon
    }()
    lazy var saveBtn:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "saveImage"), for: .normal)
        return btn
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    private func setup(){
        contentView.addSubview(image)
        image.addSubview(title)
        image.addSubview(type)
        contentView.addSubview(saveBtn)
        image.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        saveBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24)
            make.top.equalToSuperview().offset(24)
        }
        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-24)
        }
        type.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.bottom.equalTo(title.snp.top).offset(-8)
        }
    }
}
