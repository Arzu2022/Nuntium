//
//  TermsVC.swift
//  Nuntium
//
//  Created by AziK's  MAC on 16.04.23.
//

import UIKit

class TermsVC: BaseViewController<TermsViewModel> {

    private lazy var termsTV:UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.text = NSLocalizedString("terms", comment: "Terms and Conditions")
        textView.sizeToFit()
        textView.isScrollEnabled = true
        textView.textColor = .black
        textView.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return textView
    }()
    // MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    // MARK: - FUNCTIONS
    private func setup(){
        self.view.backgroundColor = .white
        self.title = "Terms & Conditions"
        self.navigationController?.navigationBar.tintColor = UIColor(named: "PurpleC")

        self.view.addSubview(termsTV)
        termsTV.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(8)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    // MARK: - UIFUNCTIONS

}
