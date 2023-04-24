//
//  BookmarkVC.swift
//  Nuntium
//
//  Created by AziK's  MAC on 15.04.23.
//

import UIKit

class BookmarkVC: BaseViewController<BookmarkViewModel> {
    private lazy var emptyView:UIView = {
        let view = UIView()
        let icon = UIImageView(image: UIImage(named: "emptySave"))
        view.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        view.backgroundColor = UIColor(named: "textfield")
        view.layer.cornerRadius = 36
        return view
    }()
    private lazy var emptyTextLabel:UILabel = {
        let text = UILabel()
        text.text = "You haven't saved any articles yet. Start reading and bookmarking them now"
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return text
    }()
    private lazy var mainLabel:UILabel = {
        let text = UILabel()
        text.text = "Bookmarks"
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return text
    }()
    private lazy var secondLabel:UILabel = {
        let text = UILabel()
        text.text = "Saved articles to the library"
        text.textColor = UIColor(named:"Grey")
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return text
    }()
    private lazy var recommendColletionV:UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.itemSize = CGSize(width: screenWidth-40, height: 96)
        let view = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.showsVerticalScrollIndicator = false
        view.register(HomeRecommendCVCell.self, forCellWithReuseIdentifier: "cell")
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.getData().then { result in
            switch result {
            case .success(let data):
                self.vm.data = data
            case .failure(let err):
                self.showAlert(message: err.localizedDescription, error: true)
            }
            self.recommendColletionV.reloadData()
            self.setup()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        vm.getData().then { result in
            switch result {
            case .success(let data):
                self.vm.data = data
            case .failure(let err):
                self.showAlert(message: err.localizedDescription, error: true)
            }
            self.recommendColletionV.reloadData()
            self.setup()
        }
    }
    // MARK: - FUNCTIONS
    private func isEmptyData(){
        recommendColletionV.removeFromSuperview()
        self.view.addSubview(emptyView)
        self.view.addSubview(emptyTextLabel)
        
        emptyView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(72)
        }
        emptyTextLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(screenWidth/6)
            make.right.equalToSuperview().offset(-screenWidth/6)
        }
    }
    private func setup(){
        self.view.backgroundColor = .white
        self.view.addSubview(mainLabel)
        self.view.addSubview(secondLabel)
        self.view.addSubview(recommendColletionV)
        
        mainLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        secondLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(mainLabel.snp.bottom).offset(8)
        }
        if vm.data.count == 0 {
            isEmptyData()
        } else {
            recommendColletionV.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview().offset(-20)
                make.top.equalTo(secondLabel.snp.bottom).offset(20)
                make.bottom.equalToSuperview()
            }
        }
    }
    // MARK: - UIFUNCTIONS


}
extension BookmarkVC:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.data.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(router.newsDidSelectVC(data: self.vm.data[indexPath.row]), animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeRecommendCVCell
        cell.title.text = vm.data[indexPath.row].title
        cell.type.text = vm.data[indexPath.row].source.name
        if self.vm.data[indexPath.row].urlToImage == nil {
            cell.image.image = UIImage(named: "noImage")
        } else {
            let url = URL(string: vm.data[indexPath.row].urlToImage!)!

            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    self.showAlert(message: error.localizedDescription, error: true)
                    return
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    return
                }
                DispatchQueue.main.async {
                    cell.image.image = image
                }
            }.resume()
            }
        return cell
    }
    
}
