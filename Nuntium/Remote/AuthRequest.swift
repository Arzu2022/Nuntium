//
//  LoginRequest.swift
//  Nuntium
//
//  Created by AziK's  MAC on 17.04.23.
//
import FirebaseAuth
import Promises
import Firebase
import GoogleSignIn
import UIKit
protocol AuthRequestProtocol {
    func login(with email:String,with password:String) -> Promise<Result<Void, Error>>
    func signUp(with email:String,with password:String,username:String) -> Promise<Result<Void, Error>>
    func forgotPasswordViaMail(with email:String) -> Promise<Result<Void,Error>>
    func signout() -> Promise<Result<Void,Error>>
    func deleteUser() -> Promise<Result<Void,Error>>
    func updatePassword(with password:String) -> Promise<Result<Void,Error>>
    func signInGoogle(vc:UIViewController) -> Promise<Result<Void,Error>>
}
enum errorCustom : Error {
    case clientID,clientUser
}
class AuthRequest:AuthRequestProtocol {
    func signInGoogle(vc:UIViewController) -> Promises.Promise<Result<Void, Error>> {
        let promise = Promise<Result<Void,Error>>.pending()
        if let clientID = FirebaseApp.app()?.options.clientID {
            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = config
            GIDSignIn.sharedInstance.signIn(withPresenting: vc) { result, error in
                if error != nil {
                    promise.fulfill(.failure(error!))
                } else {
                    if let user = result?.user,
                       let idToken = user.idToken?.tokenString {
                        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                       accessToken: user.accessToken.tokenString)
                        Auth.auth().signIn(with: credential) { result, error in
                            if let _ = error {
                                promise.fulfill(.failure(error!))
                            } else {
                                promise.fulfill(.success(()))
                            }
                        }
                    } else {
                        promise.fulfill(.failure(errorCustom.clientUser))
                    }
                }
                
            }
                
            
        } else {
            promise.fulfill(.failure(errorCustom.clientID))
        }
        return promise
    }
    
    
    let name = Auth.auth().currentUser?.displayName
    let email = Auth.auth().currentUser?.email
    
    func updatePassword(with password: String) -> Promises.Promise<Result<Void, Error>> {
        let promise = Promise<Result<Void,Error>>.pending()
        if let user = Auth.auth().currentUser {
            user.updatePassword(to: password) { error in
                if error != nil {
                    promise.fulfill(.failure(error!))
                } else {
                    promise.fulfill(.success(()))
                }
            }
        }
        return promise
    }
    
    func deleteUser() -> Promises.Promise<Result<Void, Error>> {
        let promise = Promise<Result<Void, Error>>.pending()
        if let user = Auth.auth().currentUser {
            user.delete { error in
                if error != nil {
                    promise.fulfill(.failure(error!))
                } else {
                    promise.fulfill(.success(()))
                }
            }
        }
        return promise
    }
    func signout() -> Promises.Promise<Result<Void, Error>> {
        let promise = Promise<Result<Void, Error>>.pending()
        do {
            try Auth.auth().signOut()
            promise.fulfill(.success(()))
        } catch let err as NSError {
            promise.fulfill(.failure(err))
        }
        return promise
    }
    
    
    func forgotPasswordViaMail(with email:String) -> Promises.Promise<Result<Void, Error>> {
        let promise = Promise<Result<Void,Error>>.pending()
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let err = error {
                promise.fulfill(.failure(err))
            } else {
                promise.fulfill(.success(()))
            }
        }
        return promise
    }
    
    
    func signUp(with email: String, with password: String,username:String) -> Promise<Result<Void, Error>> {
        
        let promise = Promise<Result<Void, Error>>.pending()
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard self != nil else { return }
            
            guard let user = result?.user, error == nil else {
                promise.fulfill(.failure(error!))
                return
            }
            
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = username
            changeRequest.commitChanges { (error) in
                guard error == nil else {
                    promise.fulfill(.failure(error!))
                    return
                }
                promise.fulfill(.success(()))
            }
        }
        return promise
    }
    
    
    func login(with email: String, with password: String) -> Promise<Result<Void, Error>> {
        let promise = Promise<Result<Void, Error>>.pending()
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                promise.fulfill(.failure(error))
            } else {
                promise.fulfill(.success(()))
            }
        }
        return promise
    }
    
}
