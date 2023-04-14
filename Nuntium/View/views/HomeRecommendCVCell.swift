//
//  HomeRecommendCVCell.swift
//  Nuntium
//
//  Created by AziK's  MAC on 14.04.23.
//

import Foundation
import UIKit

class HomeRecommendCVCell: UICollectionViewCell {
    lazy var title:UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return text
    }()
    lazy var type:UILabel = {
        let text = UILabel()
        text.textColor = UIColor(named: "Grey")
        text.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return text
    }()
    lazy var image:UIImageView = {
        let icon = UIImageView()
        
        return icon
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
        contentView.addSubview(type)
        contentView.layer.cornerRadius = 24
        image.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(96)
        }
        type.snp.makeConstraints { make in
            make.left.equalTo(image.snp.right).offset(8)
            make.bottom.equalTo(image.snp.centerY).offset(-6)
        }
        title.snp.makeConstraints { make in
            make.left.equalTo(image.snp.right).offset(8)
            make.right.equalToSuperview().offset(-24)
            make.top.equalTo(image.snp.centerY)
        }
    }
}
