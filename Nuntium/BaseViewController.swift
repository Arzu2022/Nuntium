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
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
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
    func showAlert(message:String,error:Bool) {
        var alert:UIAlertController
        if error {
            alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        } else {
            alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        }
            alert.addAction(UIAlertAction(title: "Got it", style: .default))
            
            self.present(alert, animated: true, completion: nil)
        }
    func showToast(message: String) {
            let toast = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            present(toast, animated: true, completion: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                    toast.dismiss(animated: true, completion: nil)
                })
            })
            
            
        }
}
