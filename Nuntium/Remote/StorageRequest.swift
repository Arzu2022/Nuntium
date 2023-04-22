//
//  StorageRequest.swift
//  Nuntium
//
//  Created by AziK's  MAC on 18.04.23.
//

import Foundation
import Promises
import UIKit
import FirebaseStorage
import FirebaseAuth

protocol StorageRequestProtocol {
    func addOrUpdateProfilePhoto(with photo:Data) -> Promise<Result<Void,Error>>
    func getProfilePhoto() -> Promise<Result<UIImage,Error>>
}
class StorageRequest:StorageRequestProtocol {
    func getProfilePhoto() -> Promises.Promise<Result<UIImage, Error>> {
        let promise = Promise<Result<UIImage,Error>>.pending()
        let islandRef = Storage.storage().reference().child("profile_photos/\(Auth.auth().currentUser?.uid ?? "qwe").jpg")
        islandRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
              promise.fulfill(.failure(error))
          } else {
            let image = UIImage(data: data!)
              promise.fulfill(.success(image!))
          }
        }
        
        return promise
    }
    func addOrUpdateProfilePhoto(with photo: Data) -> Promises.Promise<Result<Void, Error>> {
        let promise = Promise<Result<Void,Error>>.pending()
        let storageRef = Storage.storage().reference().child("profile_photos").child("\( Auth.auth().currentUser?.uid ?? "qwe").jpg")
        _ = storageRef.putData(photo, metadata: nil) { metadata, error in
            if let error = error {
                promise.fulfill(.failure(error))
            } else {
                promise.fulfill(.success(()))
            }
        }
        return promise
    }
    
}
