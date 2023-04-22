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
    func getSaved() -> Promise<Result<[MainData],Error>>
}
class DataBaseRequest: DataBaseRequestProtocol {
    
    
    private let db = Firestore.firestore()
    private let userID = Auth.auth().currentUser?.uid
    
    func getSaved() -> Promises.Promise<Result<[MainData], Error>> {
        let promise = Promise<Result<[MainData], Error>>.pending()
        db.collection("saved_\(userID ?? "nouser")").getDocuments() { (querySnapshot, err) in
            if let err = err {
                promise.fulfill(.failure(err))
            } else {
                var data :[MainData] = []
                for document in querySnapshot!.documents {
                    do {
                        let person = try JSONDecoder().decode(MainData.self, from: document.data().first!.value as! Data)
                        data.append(person)
                    } catch let err {
                        print(err.localizedDescription)
                    }
                }
                promise.fulfill(.success(data))

            }
        }
        return promise
    }
    
    func saveData(data: MainData) -> Promise<Result<Void, Error>> {
        let promise = Promise<Result<Void, Error>>.pending()
        let jsonData = try? JSONEncoder().encode(data)
        db.collection("saved_\(userID ?? "nouser")").addDocument(data: ["mysaved":jsonData!], completion: { error in
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
                    promise.fulfill(.success((document.data().first?.value)! as! [String]))
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
