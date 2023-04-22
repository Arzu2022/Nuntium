//
//  NewsDidSelectViewModel.swift
//  Nuntium
//
//  Created by AziK's  MAC on 23.04.23.
//

import Foundation
class NewsDidSelectViewModel {
    let requestDB = DataBaseRequest()
    var data:MainData
    init(data: MainData) {
        self.data = data
    }
}
