//
//  HelpVC.swift
//  Nuntium
//
//  Created by AziK's  MAC on 16.04.23.
//

import UIKit

class AboutUsVC: BaseViewController<AboutUsVCViewModel> {

    
    // MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    // MARK: - FUNCTIONS
    private func setup(){
        self.view.backgroundColor = .white
        self.title = "About us"
    }
    // MARK: - UIFUNCTIONS


}
