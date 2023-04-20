//
//  HomeViewModel.swift
//  Nuntium
//
//  Created by AziK's  MAC on 12.04.23.
//

import Foundation
import UIKit
import Promises
class HomeViewModel {
    
    let request = NewsRequest()
    var errorMessageTopicCV:String = ""
    var topicCVData:[MainData] = []
    var recommendCVData: [MainData] = []
    var checkSeeAll:Bool = true
    //comes from firebase
    var categoryCollectionVdata:[String] = ["business","entertainment","health","science","sports","technology"]
    
    var checkIndexCategory:Bool = false
    
    func getData(api:API.RawValue) -> Promise<Result<[MainData],Error>>{
        let promise = Promise<Result<[MainData],Error>>.pending()
        request.getData(api: api).then { result in
            promise.fulfill(result)
        }
        return promise
    }
    func searchText(text:String) -> Promise<Result<[MainData],Error>> {
        let promise = Promise<Result<[MainData],Error>>.pending()
        request.searchNews(text: text).then { result in
            promise.fulfill(result)
        }
        return promise
    }
}
