//
//  CommentCVCell.swift
//  Nuntium
//
//  Created by AziK's  MAC on 23.04.23.
//

import UIKit
class CommentCVCell:UICollectionViewCell {
    lazy var image:UIImageView = {
        let icon = UIImageView()
        icon.layer.cornerRadius = 20
        icon.layer.masksToBounds = true
        return icon
    }()
    lazy var name:UILabel = {
        let text = UILabel()
        text.textColor = UIColor(named: "Grey")
        text.numberOfLines = 1
        text.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return text
    }()
    lazy var comment:UILabel = {
        let text = UILabel()
        text.textColor = UIColor(named: "Grey")
        text.numberOfLines = 1
        text.lineBreakMode = .byTruncatingTail
        text.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setup(){
        contentView.addSubview(image)
        contentView.addSubview(name)
        contentView.addSubview(comment)
        
        image.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
        name.snp.makeConstraints { make in
            make.bottom.equalTo(self.image.snp.centerY).offset(-1)
            make.left.equalTo(self.image.snp.right).offset(3)
        }
        comment.snp.makeConstraints { make in
            make.top.equalTo(self.image.snp.centerY).offset(1)
            make.left.equalTo(self.image.snp.right).offset(3)
            make.right.equalToSuperview().offset(-20)
        }

    }
}
