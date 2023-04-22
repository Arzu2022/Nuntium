//
//  BookmarkViewModel.swift
//  Nuntium
//
//  Created by AziK's  MAC on 15.04.23.
//

import Foundation
import UIKit
class BookmarkViewModel {
    let requestDB = DataBaseRequest()
    var data: [MainData] = []
    init() {
        requestDB.getSaved().then { result in
            switch result {
            case .success(let data):
                self.data = data
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
//    [
//       HomeTopicCVModel(title: "The latest situation in the presidential election", type: "POLITICS", image: UIImage(named: "test")!),
//       HomeTopicCVModel(title: "Lorem loem loerem lroem", type: "ART", image: UIImage(named: "test")!),
//       HomeTopicCVModel(title: "The latest situation in the presidential election", type: "GAMING", image: UIImage(named: "test")!),
//       HomeTopicCVModel(title: "Lorem loem loerem lroem", type: "FASION", image: UIImage(named: "test")!)
//        ]
}
