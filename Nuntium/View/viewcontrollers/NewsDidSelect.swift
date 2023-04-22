//
//  NewsDidSelect.swift
//  Nuntium
//
//  Created by AziK's  MAC on 23.04.23.
//

import UIKit

class NewsDidSelect: BaseViewController<NewsDidSelectViewModel> {
    private lazy var backImage : UIImageView = {
        let imageV = UIImageView()
        return imageV
    }()
    private lazy var titleLabel: UILabel = {
        let text = UILabel()
        text.numberOfLines = 2
        text.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        text.textColor = .white
        return text
    }()
    private lazy var typeLabel: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        text.textColor = .white
        return text
    }()
    private lazy var viewBack: UIView = {
        let view = UIView()
        view.addSubview(typeLabel)
        typeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        view.backgroundColor = UIColor(named: "PurpleC")
        view.layer.cornerRadius = 12
        return view
    }()
    private lazy var contentLabel: UILabel = {
        let text = UILabel()
        
        return text
    }()
    private lazy var shareBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "share"), for: .normal)
        btn.addTarget(self, action: #selector(onClickShare), for: .touchUpInside)
        return btn
    }()
    // MARK: - Closures
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        setup()
    }
    // MARK: - Functions
    private func setData(){
        if self.vm.data.urlToImage == nil {
            backImage.image = UIImage(named: "noImage")
        } else {
            let url = URL(string: vm.data.urlToImage!)!

            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    // Handle the error here
                    self.showAlert(message: error.localizedDescription, error: true)
                    return
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    return
                }
                DispatchQueue.main.async {
                    self.backImage.image = image
                }
            }.resume()
            }
        self.titleLabel.text = vm.data.title
        self.typeLabel.text = vm.data.source.name
        self.contentLabel.text = vm.data.content
    }
    private func setup(){
        navigationItem.setRightBarButton(UIBarButtonItem(title: "", image:UIImage(named: "save"),  target: self, action: #selector(onClickRightBtnNav)), animated: true)
        
        self.view.backgroundColor = .white
        self.view.addSubview(backImage)
        self.backImage.addSubview(titleLabel)
        self.backImage.addSubview(viewBack)
        self.view.addSubview(contentLabel)
        self.backImage.addSubview(shareBtn)
        
        backImage.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(self.view.snp.centerY).offset(-20)
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
        viewBack.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalTo(self.titleLabel.snp.top).offset(-8)
            make.width.equalTo(titleLabel.text!.count)
            make.height.equalTo(24)
        }
        shareBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-13)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
        }
        

    }
    // MARK: - UIFunctions
    @objc
    func onClickShare(){
        //next time
    }
    @objc
    private func onClickRightBtnNav(){
        vm.requestDB.saveData(data: vm.data).then { result in
            switch result {
                case .success(()):
                self.showToast(message: "Saved")
                case .failure(let err):
                self.showAlert(message: err.localizedDescription, error: true)
            }
        }
    }
}
