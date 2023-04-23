//
//  NewsDidSelectViewModel.swift
//  Nuntium
//
//  Created by AziK's  MAC on 23.04.23.
//

import Foundation
import UIKit
class NewsDidSelectViewModel {
    let requestDB = DataBaseRequest()
    let requestStorage = StorageRequest()
    var data:MainData
    var comments:[CommentModel] = [
    CommentModel(image: UIImage(named: "noUser")!, name: "azik", comment: "wow, that is so good"),
    CommentModel(image: UIImage(named: "noUser")!, name: "rasim", comment: "perfecttt"),
    CommentModel(image: UIImage(named: "noUser")!, name: "kazim", comment: "wow, that is so good"),
    CommentModel(image: UIImage(named: "noUser")!, name: "fuad", comment: "wow, that is so good")
    ]
    init(data: MainData) {
        self.data = data
    }
}
