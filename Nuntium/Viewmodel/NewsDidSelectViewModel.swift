//
//  NewsDidSelectViewModel.swift
//  Nuntium
//
//  Created by AziK's  MAC on 23.04.23.
//

import Foundation
import UIKit
import Promises

class NewsDidSelectViewModel {
    let requestDB = DataBaseRequest()
    let requestStorage = StorageRequest()
    let requestAuth = AuthRequest()
    var data:MainData
    var comments:[CommentModel] = []
    init(data: MainData) {
        self.data = data
    }
    func getComment()->Promise<Result<[CommentModel],Error>>{
        let promise  = Promise<Result<[CommentModel],Error>>.pending()
        self.requestDB.getComments(key: ((data.title ?? "noTitle")+(data.source.name ?? "noUser"))).then { result in
            promise.fulfill(result)
        }
        return promise
    }
    func getProfileImage() -> UIImage {
        requestStorage.getProfilePhoto().then { result in
            switch result {
            case .failure( _):
                return UIImage(named: "noUser")
            case .success(let image):
                return image
            }
        }
        return UIImage(named: "noUser")!
    }
}
