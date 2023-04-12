//
//  Router.swift
//  Nuntium
//
//  Created by AziK's  MAC on 12.04.23.
//

import UIKit
public protocol RouterProtocol {
    func homeVC() -> UIViewController
}
public class Router:RouterProtocol {
    public func homeVC() -> UIViewController {
        return HomeVC(vm: HomeViewModel(), router: self)
    }
    
    
}
