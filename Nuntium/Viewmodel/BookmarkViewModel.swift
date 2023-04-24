//
//  BookmarkViewModel.swift
//  Nuntium
//
//  Created by AziK's  MAC on 15.04.23.
//

import Foundation
import UIKit
import Promises
class BookmarkViewModel {
    let requestDB = DataBaseRequest()
    var data: [MainData] = []
    func getData()-> Promise<Result<[MainData],Error>>{
        let promise = Promise<Result<[MainData],Error>>.pending()
        requestDB.getSaved().then { result in
            promise.fulfill(result)
        }
        return promise
    }
}
