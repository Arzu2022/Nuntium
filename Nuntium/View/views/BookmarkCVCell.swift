//
//  BookmarkCVCell.swift
//  Nuntium
//
//  Created by AziK's  MAC on 25.04.23.
//

import Foundation
import UIKit
protocol BookmarkCVCellDelegate: AnyObject {
    func collectionViewCell(_ cell: BookmarkCVCell, indexPathForItemAt location: CGPoint) -> IndexPath?
    func collectionViewCell(_ cell: BookmarkCVCell, didTapItemAt indexPath: IndexPath)
}
class BookmarkCVCell: UICollectionViewCell {
    var delegate:BookmarkCVCellDelegate?
    lazy var title:UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 2
        text.lineBreakMode = .byTruncatingTail
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
        icon.layer.cornerRadius = 12
        icon.layer.masksToBounds = true
        return icon
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupGestureRecognizer()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        setupGestureRecognizer()
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
    private func setupGestureRecognizer() {
           let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
           contentView.addGestureRecognizer(longGesture)
       }
       
    @objc private func handleTapGesture(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: contentView)
               if let indexPath = delegate?.collectionViewCell(self, indexPathForItemAt: location) {
                   delegate?.collectionViewCell(self, didTapItemAt: indexPath)
               }
           }
}

