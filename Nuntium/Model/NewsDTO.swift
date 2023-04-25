//
//  NewsDTO.swift
//  Nuntium
//
//  Created by AziK's  MAC on 20.04.23.
//

import Foundation
public struct NewsDTO:Codable{
   public let status:String
   public let totalResults:Int
   public let articles:[MainData]
}
public struct MainData:Codable {
    var source:Source
    let author:String?
    let title:String?
    let description:String?
    let publishedAt:String?
    let url:String?
    let urlToImage:String?
    let content:String?
}
struct Source:Codable{
    var id:String?
    var name:String?
}
