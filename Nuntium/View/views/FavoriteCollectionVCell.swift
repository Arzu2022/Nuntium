//
//  FavoriteCollectionVCell.swift
//  Nuntium
//
//  Created by AziK's  MAC on 13.04.23.
//

import Foundation
import UIKit
import SnapKit

class FavoriteCollectionVCell : UICollectionViewCell {
    lazy var mainText:UILabel = {
        let text = UILabel()
        text.textColor = UIColor(named: "Grey")
        text.font = UIFont.systemFont(ofSize: 20, weight: .bold)
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
        if contentView.backgroundColor == UIColor(named: "PurpleC"){
            mainText.textColor = .white
        } else {
            mainText.textColor = UIColor(named: "Grey")
        }
        mainText.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
    }
}
