//
//  ViewController.swift
//  Nuntium
//
//  Created by AziK's  MAC on 12.04.23.
//

import UIKit

class HomeVC: BaseViewController<HomeViewModel>{
    
    private lazy var mainLabel:UILabel = {
        let text = UILabel()
        text.text = "Browse"
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return text
    }()
    private lazy var secondLabel:UILabel = {
        let text = UILabel()
        text.text = "Discover things of this world"
        text.textColor = UIColor(named:"Grey")
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return text
    }()
    private lazy var searchBar: UISearchBar = {
        let searchbar = UISearchBar()
            searchbar.autocorrectionType = .no
           // searchbar.setImage(UIImage(), for: .search, state: .normal)
            searchbar.placeholder = "Search"
        searchbar.searchBarStyle = .minimal
            searchbar.delegate = self
        return searchbar
        }()
    private lazy var categoryCollectionV:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.itemSize = CGSize(width: screenWidth/3, height: 35)
        let view = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.isUserInteractionEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.register(HomeCategoryCollectioVCell.self, forCellWithReuseIdentifier: "cell")
        return view
    }()
    private lazy var topicCategoryColletionV:UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.itemSize = CGSize(width: screenWidth/1.5, height: 220)
        let view = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.showsHorizontalScrollIndicator = false
        view.register(TopicCategryCollectionVCell.self, forCellWithReuseIdentifier: "cell")
        return view
    }()
    private lazy var recommendLabel:UILabel = {
        let text = UILabel()
        text.text = "Recommended for you"
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return text
    }()
    private lazy var generalLabel:UILabel = {
        let text = UILabel()
        text.text = "General news"
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return text
    }()
    private lazy var seeAllBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("See All", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        btn.setTitleColor(UIColor(named:"Grey"), for: .normal)
        btn.addTarget(self, action: #selector(onClickSeeAll), for: .touchUpInside)
        return btn
    }()
    private lazy var seeLessBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("See Less", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        btn.setTitleColor(UIColor(named:"Grey"), for: .normal)
        btn.addTarget(self, action: #selector(onClickSeeLess), for: .touchUpInside)
        return btn
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
    private lazy var clickRecommendColletionV:UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.itemSize = CGSize(width: screenWidth-48, height: screenHeight/3)
        let view = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.showsVerticalScrollIndicator = false
        view.register(HomeClickRecommendCVCell.self, forCellWithReuseIdentifier: "cell")
        return view
    }()
    //MARK: VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vm.getData(api: API.general.rawValue).then { result in
            switch result {
            case .failure(let err):
                self.showAlert(message: err.localizedDescription, error: true)
            case .success(let data):
                self.vm.topicCVData = data
            }
        }.then { result in
            self.checkTypeRecommendCVData()
        }.then { result in
            self.setup()
        }
        
    }
    //MARK: FUNCTIONS
    private func checkSpacing(text:String)->Bool {
        for i in text{
            if i == " "{
                return false
            }
        }
        return true
    }
    private func checkTypeRecommendCVData(){
        if vm.categoryCollectionVdata.first == "sport" {
            vm.getData(api: API.sport.rawValue).then { result in
                switch result {
                case .success(let data):
                    self.vm.recommendCVData = data
                    self.recommendColletionV.reloadData()
                case .failure(let err):
                    self.showAlert(message: err.localizedDescription, error: true)
                }
            }
        } else if vm.categoryCollectionVdata.first == "business" {
            vm.getData(api: API.business.rawValue).then { result in
                switch result {
                case .success(let data):
                    print(data)
                    self.vm.recommendCVData.append(contentsOf: data)
                    self.recommendColletionV.reloadData()
                case .failure(let err):
                    self.showAlert(message: err.localizedDescription, error: true)
                }
            }
        } else if vm.categoryCollectionVdata.first == "technology" {
            vm.getData(api: API.technology.rawValue).then { result in
                switch result {
                case .success(let data):
                    self.vm.recommendCVData = data
                    self.recommendColletionV.reloadData()
                case .failure(let err):
                    self.showAlert(message: err.localizedDescription, error: true)
                }
            }
        } else if vm.categoryCollectionVdata.first == "entertainment" {
            vm.getData(api: API.entertainment.rawValue).then { result in
                switch result {
                case .success(let data):
                    self.vm.recommendCVData = data
                    self.recommendColletionV.reloadData()
                case .failure(let err):
                    self.showAlert(message: err.localizedDescription, error: true)
                }
            }
        } else if vm.categoryCollectionVdata.first == "health" {
            vm.getData(api: API.health.rawValue).then { result in
                switch result {
                case .success(let data):
                    self.vm.recommendCVData = data
                    self.recommendColletionV.reloadData()
                case .failure(let err):
                    self.showAlert(message: err.localizedDescription, error: true)
                }
            }
        } else {
            vm.getData(api: API.science.rawValue).then { result in
                switch result {
                case .success(let data):
                    self.vm.recommendCVData = data
                    self.recommendColletionV.reloadData()
                case .failure(let err):
                    self.showAlert(message: err.localizedDescription, error: true)
                }
            }
        }
    }
    private func setup(){
        self.view.backgroundColor = .white
        self.view.addSubview(mainLabel)
        self.view.addSubview(secondLabel)
        self.view.addSubview(searchBar)
        self.view.addSubview(topicCategoryColletionV)
        self.view.addSubview(recommendLabel)
        self.view.addSubview(seeAllBtn)
        self.view.addSubview(recommendColletionV)
        self.view.addSubview(generalLabel)

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
        searchBar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(secondLabel.snp.bottom).offset(20)
        }
        generalLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(searchBar.snp.bottom).offset(8)
        }
        topicCategoryColletionV.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(generalLabel.snp.bottom).offset(16)
            make.height.equalTo(220)
        }
        recommendLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(topicCategoryColletionV.snp.bottom).offset(16)
        }
        seeAllBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalTo(recommendLabel.snp.centerY).offset(2)
        }
        recommendColletionV.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(recommendLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview().offset(-60)
        }
    }
    //MARK: UIFUNCTIONS
    @objc
    func onClickSave(_ sender : UIButton) {
        //save
        let position = sender.convert(CGPoint.zero, to: self.topicCategoryColletionV)
        guard let index = self.topicCategoryColletionV.indexPathForItem(at: position) else {return}
        vm.requestDB.saveData(data: vm.topicCVData[index.row]).then { result in
            switch result {
                case .success(()):
                self.showToast(message: "Saved")
                case .failure(let err):
                self.showAlert(message: err.localizedDescription, error: true)
            }
        }
    }
    @objc
    func onClickSeeLess(){
        self.categoryCollectionV.removeFromSuperview()
        self.clickRecommendColletionV.removeFromSuperview()
        self.seeLessBtn.removeFromSuperview()
        self.recommendLabel.removeFromSuperview()
        setup()
        recommendLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    @objc
    func onClickSeeAll(){
        self.recommendColletionV.removeFromSuperview()
        self.topicCategoryColletionV.removeFromSuperview()
        self.seeAllBtn.removeFromSuperview()
        self.searchBar.removeFromSuperview()
        self.generalLabel.removeFromSuperview()
        
        self.view.addSubview(clickRecommendColletionV)
        self.view.addSubview(categoryCollectionV)
        self.view.addSubview(seeLessBtn)
        
        recommendLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        
        recommendLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(secondLabel.snp.bottom).offset(20)
        }
        seeLessBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalTo(recommendLabel.snp.centerY)
        }
        categoryCollectionV.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(seeLessBtn.snp.bottom).offset(8)
            make.height.equalTo(48)
        }
        
        clickRecommendColletionV.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.top.equalTo(categoryCollectionV.snp.bottom).offset(12)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
extension HomeVC :UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate {
    //MARK: SERACHBAR FUNCTIONS
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       }
        func updateSearchResults(for searchController: UISearchController) {
       }
       func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           if searchBar.text != "" {
               if checkSpacing(text:searchBar.text!) {
                   self.vm.searchText(text: searchBar.text!).then { result in
                       switch result {
                       case .failure(let err):
                           self.showAlert(message: err.localizedDescription, error: true)
                       case .success(let data):
                           if data.count != 0 {
                               self.vm.topicCVData = data
                               self.topicCategoryColletionV.reloadData()
                           }
                       }
                   }} else {
                       self.showAlert(message: "Add only a word, not spacing", error: true)
                   }
           } else {
               self.showAlert(message: "Write something then click to search!", error: true)
           }
       }
    //MARK: COLLECTIONVIEW FUNCTIONS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionV {
            return vm.categoryCollectionVdata.count
        } else if collectionView == topicCategoryColletionV {
            return vm.topicCVData.count
        } else if collectionView == clickRecommendColletionV {
            return vm.recommendCVData.count
        } else {
            return vm.recommendCVData.count
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionV {
            let array = vm.categoryCollectionVdata.sorted(by: { $0 ==  vm.categoryCollectionVdata[indexPath.row] && $1 != vm.categoryCollectionVdata[indexPath.row]})
                vm.categoryCollectionVdata = array
            collectionView.reloadData()
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
            self.checkTypeRecommendCVData()
            self.clickRecommendColletionV.reloadData()
            self.clickRecommendColletionV.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            self.showToastForWait(message: "Please, wait a minute for refreshing news")
        } else if collectionView == topicCategoryColletionV {
            self.navigationController?.pushViewController(router.newsDidSelectVC(data: self.vm.topicCVData[indexPath.row]), animated: true)
        } else if collectionView == clickRecommendColletionV {
            self.navigationController?.pushViewController(router.newsDidSelectVC(data: self.vm.recommendCVData[indexPath.row]), animated: true)
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCategoryCollectioVCell
            cell.mainText.text = vm.categoryCollectionVdata[indexPath.row]
            if indexPath.row == 0 {
                cell.mainText.textColor = .white
                cell.contentView.backgroundColor = UIColor(named: "PurpleC")
            } else {
                cell.mainText.textColor = UIColor(named: "Grey")
                cell.contentView.backgroundColor = UIColor(named: "textfield")
            }
            return cell
        } else if collectionView == recommendColletionV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeRecommendCVCell
            if self.vm.recommendCVData[indexPath.row].urlToImage == nil {
                cell.image.image = UIImage(named: "noImage")
            } else {
                let url = URL(string: vm.recommendCVData[indexPath.row].urlToImage!)!

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
                        cell.image.image = image
                    }
                }.resume()
                }
        cell.title.text = vm.recommendCVData[indexPath.row].title
        cell.type.text = vm.recommendCVData[indexPath.row].source.name
            return cell
        } else if collectionView == clickRecommendColletionV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeClickRecommendCVCell
            if self.vm.recommendCVData[indexPath.row].urlToImage == nil {
                cell.image.image = UIImage(named: "noImage")
            } else {
                let url = URL(string: vm.recommendCVData[indexPath.row].urlToImage!)!

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
                        cell.image.image = image
                    }
                }.resume()
                }
            cell.title.text = vm.recommendCVData[indexPath.row].title
            cell.saveBtn.tag = indexPath.row
            cell.saveBtn.addTarget(self, action: #selector(onClickSave(_:)), for: .touchUpInside)
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TopicCategryCollectionVCell
                if self.vm.topicCVData[indexPath.row].urlToImage == nil {
                    cell.image.image = UIImage(named: "noImage")
                } else {
                    let url = URL(string: vm.topicCVData[indexPath.row].urlToImage!)!

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
            cell.title.text = vm.topicCVData[indexPath.row].title
            cell.type.text = vm.topicCVData[indexPath.row].source.name
            cell.saveBtn.tag = indexPath.row
            cell.saveBtn.addTarget(self, action: #selector(onClickSave(_:)), for: .touchUpInside)
            return cell
        }
    }
    
}
