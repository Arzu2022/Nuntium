//
//  HomeCategoryCollectioVCell.swift
//  Nuntium
//
//  Created by AziK's  MAC on 14.04.23.
//

import Foundation
import UIKit
class HomeCategoryCollectioVCell:UICollectionViewCell {
    lazy var mainText:UILabel = {
        let text = UILabel()
        text.textColor = UIColor(named: "Grey")
        text.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return text
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setup(){
        contentView.addSubview(mainText)
        contentView.layer.cornerRadius = 16
        contentView.backgroundColor = UIColor(named: "textfield")
        
        mainText.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}
