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
    var checkSeeAll:Bool = true
    //comes from firebase
    var categoryCollectionVdata:[String] = ["business","entertainment","health","science","sports","technology"]
    
    var recommendCVData: [HomeTopicCVModel] = [
        HomeTopicCVModel(title: "The latest situation in the presidential election", type: "POLITICS", image: UIImage(named: "test")!),
        HomeTopicCVModel(title: "Lorem loem loerem lroem", type: "ART", image: UIImage(named: "test")!)
        ]
    var clickRecommendCVData: [HomeTopicCVModel] = [
        HomeTopicCVModel(title: "The latest situation in the presidential election", type: "POLITICS", image: UIImage(named: "test")!),
        HomeTopicCVModel(title: "Lorem loem loerem lroem", type: "ART", image: UIImage(named: "test")!)
        ]
    var checkIndexCategory:Bool = false
    
    func getTopicCVData() -> Promise<Result<[MainData],Error>>{
        let promise = Promise<Result<[MainData],Error>>.pending()
        request.getGeneral().then { result in
            promise.fulfill(result)
        }
        return promise
    }
}
