//
//  TermsVC.swift
//  Nuntium
//
//  Created by AziK's  MAC on 16.04.23.
//

import UIKit

class TermsVC: BaseViewController<TermsViewModel> {

    private lazy var gmailLabel:UILabel = {
        let text = UILabel()
        text.text = ""
        text.textColor = UIColor(named:"Grey")
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return text
    }()
    // MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    // MARK: - FUNCTIONS
    private func setup(){
        self.view.backgroundColor = .white
        self.title = "Terms & Conditions"
    }
    // MARK: - UIFUNCTIONS

}
