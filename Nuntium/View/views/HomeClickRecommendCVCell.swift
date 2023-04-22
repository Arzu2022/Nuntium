//
//  HomeClickRecommendCVCell.swift
//  Nuntium
//
//  Created by AziK's  MAC on 14.04.23.
//

import Foundation
import UIKit

class HomeClickRecommendCVCell:UICollectionViewCell {
    lazy var title:UILabel = {
        let text = UILabel()
        text.textColor = UIColor(named: "Grey")
        text.numberOfLines = 2
        text.lineBreakMode = .byTruncatingTail
        text.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return text
    }()
    lazy var image:UIImageView = {
        let icon = UIImageView()
        
        return icon
    }()
    lazy var saveBtn:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "save"), for: .normal)
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
        contentView.addSubview(title)
        contentView.addSubview(saveBtn)
        contentView.layer.cornerRadius = 24
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .white
        contentView.layer.borderColor = UIColor(white: 0.8, alpha: 0.5).cgColor
        contentView.layer.borderWidth = 1
        saveBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-24)
        }
        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-50)
            make.centerY.equalTo(saveBtn.snp.centerY)
        }
        image.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(title.snp.top).offset(-16)
        }
    }
}
