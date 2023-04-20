//
//  NewsRequest.swift
//  Nuntium
//
//  Created by AziK's  MAC on 20.04.23.
//

import Foundation
import Promises
import Alamofire
enum API:String {
    case general = "https://newsapi.org/v2/top-headlines?country=us&category=general&apiKey=73bf7f5ef282482f9fd8a41a5d4d188d"
    case sport = "https://newsapi.org/v2/top-headlines?country=us&category=sport&apiKey=73bf7f5ef282482f9fd8a41a5d4d188d"
    case business = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=73bf7f5ef282482f9fd8a41a5d4d188d"
    case health = "https://newsapi.org/v2/top-headlines?country=us&category=health&apiKey=73bf7f5ef282482f9fd8a41a5d4d188d"
    case science = "https://newsapi.org/v2/top-headlines?country=us&category=science&apiKey=73bf7f5ef282482f9fd8a41a5d4d188d"
    case technology = "https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=73bf7f5ef282482f9fd8a41a5d4d188d"
    case entertainment = "https://newsapi.org/v2/top-headlines?country=us&category=entertainment&apiKey=73bf7f5ef282482f9fd8a41a5d4d188d"
}
protocol NewsRequestProtocol{
    func getData(api:API.RawValue)->Promise<Result<[MainData],Error>>
    func searchNews(text:String) -> Promise<Result<[MainData], Error>>
}
class NewsRequest:NewsRequestProtocol {
    func searchNews(text: String) -> Promise<Result<[MainData], Error>> {
        let promise = Promise<Result<[MainData],Error>>.pending()
        AF.request(URL(string: "https://newsapi.org/v2/everything?apiKey=73bf7f5ef282482f9fd8a41a5d4d188d&q=\(text)")!, method: .get).responseDecodable(of: NewsDTO.self) { response in
            if let err = response.error {
                promise.fulfill(.failure(err))
            } else {
                let data = response.value
                if data?.status == "ok" {
                    promise.fulfill(.success(data!.articles))
                } else {
                    promise.fulfill(.failure(response.error!))
                }
            }
        }
        return promise
    }
    func getData(api:API.RawValue) ->Promise<Result<[MainData],Error>> {
        let promise = Promise<Result<[MainData],Error>>.pending()
        AF.request(URL(string: api)!, method: .get).responseDecodable(of: NewsDTO.self) { response in
            if let err = response.error {
                promise.fulfill(.failure(err))
            } else {
                let data = response.value
                if data?.status == "ok" {
                    promise.fulfill(.success(data!.articles))
                } else {
                    promise.fulfill(.failure(response.error!))
                }
            }
        }
        return promise
    }
}
