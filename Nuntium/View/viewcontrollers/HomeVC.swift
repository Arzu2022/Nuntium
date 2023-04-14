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
        layout.itemSize = CGSize(width: screenWidth/4, height: 30)
        let view = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.showsHorizontalScrollIndicator = false
        view.register(HomeCategoryCollectioVCell.self, forCellWithReuseIdentifier: "cell")
        return view
    }()
    private lazy var topicCategoryColletionV:UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.itemSize = CGSize(width: screenWidth/1.5, height: screenHeight/3)
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
    private lazy var seeAllBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("See All", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        btn.setTitleColor(UIColor(named:"Grey"), for: .normal)
        btn.addTarget(self, action: #selector(onClickSeeAll), for: .touchUpInside)
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
        layout.itemSize = CGSize(width: screenWidth-48, height: screenHeight/3.5)
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
        setup()
    }
    //MARK: FUNCTIONS
    private func setup(){
        self.view.backgroundColor = .white
        self.view.addSubview(mainLabel)
        self.view.addSubview(secondLabel)
        self.view.addSubview(searchBar)
        self.view.addSubview(categoryCollectionV)
        self.view.addSubview(topicCategoryColletionV)
        self.view.addSubview(recommendLabel)
        self.view.addSubview(seeAllBtn)
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
        searchBar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(secondLabel.snp.bottom).offset(20)
         //   make.height.equalTo(72)
        }
        categoryCollectionV.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.height.equalTo(48)
        }
        topicCategoryColletionV.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(categoryCollectionV.snp.bottom).offset(16)
            make.height.equalTo(screenHeight/3)
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
            make.height.equalTo(96)
        }
    }
    //MARK: UIFUNCTIONS
    @objc
    func onClickSeeAll(){
        self.recommendColletionV.removeFromSuperview()
        self.topicCategoryColletionV.removeFromSuperview()
        self.recommendLabel.removeFromSuperview()
        self.seeAllBtn.removeFromSuperview()
        self.view.addSubview(clickRecommendColletionV)
        clickRecommendColletionV.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.top.equalTo(categoryCollectionV.snp.bottom)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
extension HomeVC :UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate {
    //MARK: SERACHBAR FUNCTIONS
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//           if searchText == "" {
//               self.removeListLuggage()
//           } else {
//               self.vm.autocompleteGetCargos(filter: searchText).then { [weak self] state in
//                   DispatchQueue.main.async {
//                       if state {
//                           self?.removeListLuggage()
//                           self?.showListLuggage()
//                       }
//                   }
//
//               }
//           }
       }
       func updateSearchResults(for searchController: UISearchController) {
           
       }
       func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           // Perform search
           // searchBar.text = ""
       }
    //MARK: COLLECTIONVIEW FUNCTIONS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionV {
            return vm.categoryCollectionVdata.count
        } else if collectionView == topicCategoryColletionV {
            return vm.topicCVData.count
        } else if collectionView == clickRecommendColletionV {
            return vm.clickRecommendCVData.count
        } else {
            return vm.recommendCVData.count
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            for (index, value) in vm.checkIndexPath.enumerated() {
//                if value == vm.data[indexPath.row] {
//                    vm.checkIndexPath.remove(at: index)
//                    vm.checkIndex = true
//                    break
//                }
//            }
//            if  !vm.checkIndex {
//                vm.checkIndexPath.append(vm.data[indexPath.row])
//                collectionView.cellForItem(at: indexPath)?.contentView.backgroundColor = UIColor(named: "PurpleC")
//            } else {
//                vm.checkIndex = false
//                collectionView.cellForItem(at: indexPath)?.contentView.backgroundColor = UIColor(named: "textfield")
//            }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCategoryCollectioVCell
            if vm.categoryCollectionVdata[indexPath.row] == "Random" {
                cell.contentView.backgroundColor = UIColor(named: "PurpleC")
                cell.mainText.textColor = .white
            }
            cell.mainText.text = vm.categoryCollectionVdata[indexPath.row]
            return cell
        } else if collectionView == recommendColletionV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeRecommendCVCell
            cell.image.image = vm.recommendCVData[indexPath.row].image
            cell.title.text = vm.recommendCVData[indexPath.row].title
            cell.type.text = vm.recommendCVData[indexPath.row].type
            return cell
        } else if collectionView == clickRecommendColletionV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeClickRecommendCVCell
            cell.image.image = vm.clickRecommendCVData[indexPath.row].image
            cell.title.text = vm.clickRecommendCVData[indexPath.row].title
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TopicCategryCollectionVCell
            cell.image.image = vm.topicCVData[indexPath.row].image
            cell.title.text = vm.topicCVData[indexPath.row].title
            cell.type.text = vm.topicCVData[indexPath.row].type
            return cell
        }
    }
    
}
