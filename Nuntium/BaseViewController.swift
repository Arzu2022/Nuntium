//
//  BaseViewController.swift
//  Nuntium
//
//  Created by AziK's  MAC on 12.04.23.
//

import UIKit

class BaseViewController<VM>: UIViewController {

    var vm :VM
    var router:Router
    
    init(vm:VM,router:Router) {
        self.vm = vm
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
