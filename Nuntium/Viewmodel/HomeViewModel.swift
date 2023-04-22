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
    let requestDB = DataBaseRequest()
    
    var errorMessageTopicCV:String = ""
    var topicCVData:[MainData] = []
    var recommendCVData: [MainData] = []
    var checkSeeAll:Bool = true
    //comes from firebase
    var categoryCollectionVdata:[String] = []
    var checkIndexCategory:Bool = false
    init (){
        requestDB.getCategory().then { result in
            switch result {
            case .success(let data):
                for i in data {
                    let t = i.components(separatedBy: "  ")
                    self.categoryCollectionVdata.append(t[1])
                }
                //self.categoryCollectionVdata = data
            case .failure(let err):
                print(err)
            }
        }
    }
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
