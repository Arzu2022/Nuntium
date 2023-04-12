//
//  Router.swift
//  Nuntium
//
//  Created by AziK's  MAC on 12.04.23.
//

import UIKit
public protocol RouterProtocol {
    func homeVC() -> UIViewController
    func initialVC() -> UIViewController
    func getStartedVC() -> UIViewController
}
public class Router:RouterProtocol {
    public func initialVC() -> UIViewController {
        return InitalVC(vm: InitialViewModel(), router: self)
    }
    
    public func getStartedVC() -> UIViewController {
        return GetStartedVC(vm: GetStartedViewModel(), router: self)
    }
    
    public func homeVC() -> UIViewController {
        return HomeVC(vm: HomeViewModel(), router: self)
    }
    
}
