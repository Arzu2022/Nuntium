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
    var checkCell = true
    weak var collectionView:UICollectionView?
    lazy var mainText:UILabel = {
        let text = UILabel()
        text.textColor = UIColor(named: "Grey")
        text.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return text
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickCell(_:)))
        contentView.addGestureRecognizer(tap)
        contentView.isUserInteractionEnabled = true
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
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
    }
    @objc
    func clickCell(_ sender:UIGestureRecognizer){
        if checkCell {
            checkCell = false
            mainText.textColor = .white
            contentView.backgroundColor = UIColor(named: "PurpleC")
        } else {
            checkCell = true
            mainText.textColor = UIColor(named: "Grey")
            contentView.backgroundColor = UIColor(named: "textfield")
        }
        guard let indexPath = collectionView?.indexPath(for: self) else {return}
        collectionView?.delegate?.collectionView?(collectionView!, didSelectItemAt: indexPath)

    }
}
