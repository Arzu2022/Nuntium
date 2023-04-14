//
//  HomeViewModel.swift
//  Nuntium
//
//  Created by AziK's  MAC on 12.04.23.
//

import Foundation
import UIKit
class HomeViewModel {
    var categoryCollectionVdata:[String] = ["Random","Sport","Daily","Best","Sport","Daily","Best"]
    var topicCVData:[HomeTopicCVModel] = [
    HomeTopicCVModel(title: "The latest situation in the presidential election", type: "POLITICS", image: UIImage(named: "test")!),
    HomeTopicCVModel(title: "Lorem loem loerem lroem", type: "ART", image: UIImage(named: "test")!)
    ]
    var recommendCVData: [HomeTopicCVModel] = [
        HomeTopicCVModel(title: "The latest situation in the presidential election", type: "POLITICS", image: UIImage(named: "test")!),
        HomeTopicCVModel(title: "Lorem loem loerem lroem", type: "ART", image: UIImage(named: "test")!)
        ]
    var clickRecommendCVData: [HomeTopicCVModel] = [
        HomeTopicCVModel(title: "The latest situation in the presidential election", type: "POLITICS", image: UIImage(named: "test")!),
        HomeTopicCVModel(title: "Lorem loem loerem lroem", type: "ART", image: UIImage(named: "test")!)
        ]
    var checkIndexPathCategory:[String] = []
    var checkIndexCategory:Bool = false
}
