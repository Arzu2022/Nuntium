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
}
class StorageRequest:StorageRequestProtocol {
    
    func addOrUpdateProfilePhoto(with photo: Data) -> Promises.Promise<Result<Void, Error>> {
        let promise = Promise<Result<Void,Error>>.pending()
        let storageRef = Storage.storage().reference().child("profile_photos").child("\(String(describing: Auth.auth().currentUser?.uid)).jpg")
        let uploadTask = storageRef.putData(photo, metadata: nil) { metadata, error in
            if let error = error {
                promise.fulfill(.failure(error))
            } else {
                promise.fulfill(.success(()))
            }
        }
        return promise
    }
    
}
