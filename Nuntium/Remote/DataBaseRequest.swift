//
//  DataBaseRequest.swift
//  Nuntium
//
//  Created by AziK's  MAC on 21.04.23.
//

import Foundation
import Promises
import FirebaseFirestore
import FirebaseAuth

protocol DataBaseRequestProtocol {
    func addCategory(data:[String]) -> Promise<Result<Void,Error>>
    func getCategory() -> Promise<Result<[String],Error>>
    func saveData(data:MainData) -> Promise<Result<Void,Error>>
    func getSaved() -> Promise<Result<MainData,Error>>
}
class DataBaseRequest: DataBaseRequestProtocol {
    
    func getSaved() -> Promises.Promise<Result<MainData, Error>> {
        let promise = Promise<Result<MainData, Error>>.pending()
        db.collection("category_\(userID ?? "nouser")").getDocuments() { (querySnapshot, err) in
            if let err = err {
                promise.fulfill(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    promise.fulfill(.success(document.value(forKey: "mycategory") as! MainData))
                }
            }
        }
        return promise
    }
    
    
    private let db = Firestore.firestore()
    private let userID = Auth.auth().currentUser?.uid
    
    func saveData(data: MainData) -> Promise<Result<Void, Error>> {
        let promise = Promise<Result<Void, Error>>.pending()
        db.collection("category_\(userID ?? "nouser")").addDocument(data: ["my saved":data], completion: { error in
            if let _ = error {
                promise.fulfill(.failure(error!))
            } else {
                promise.fulfill(.success(()))
            }
        })
        return promise
    }
    
    func getCategory() -> Promise<Result<[String], Error>> {
        let promise = Promise<Result<[String], Error>>.pending()
        db.collection("category_\(userID ?? "nouser")").getDocuments() { (querySnapshot, err) in
            if let err = err {
                promise.fulfill(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    promise.fulfill(.success(document.value(forKey: "mycategory") as! [String]))
                }
            }
        }
        return promise
    }
    func addCategory(data: [String]) -> Promise<Result<Void, Error>> {
        let promise = Promise<Result<Void, Error>>.pending()
        db.collection("category_\(userID ?? "nouser")").addDocument(data: ["mycategory":data], completion: { error in
            if let _ = error {
                promise.fulfill(.failure(error!))
            } else {
                promise.fulfill(.success(()))
            }
        })
        return promise
    }
}
