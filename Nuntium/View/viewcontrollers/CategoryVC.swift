//
//  CategoryVC.swift
//  Nuntium
//
//  Created by AziK's  MAC on 15.04.23.
//

import UIKit

class CategoryVC: BaseViewController<CategoryViewModel> {
    private lazy var mainLabel:UILabel = {
        let text = UILabel()
        text.text = "Categories"
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return text
    }()
    private lazy var secondLabel:UILabel = {
        let text = UILabel()
        text.text = "Many articles in each category"
        text.textColor = UIColor(named:"Grey")
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return text
    }()
    private lazy var collectionVItems:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.itemSize = CGSize(width: (screenWidth - 56)/2, height: 70)
        view.delegate = self
        view.dataSource = self
        view.showsVerticalScrollIndicator = false
        view.register(FavoriteCollectionVCell.self, forCellWithReuseIdentifier: "cell")
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    // MARK: - FUNCTIONS
    private func setup(){
        self.view.backgroundColor = .white
        self.view.addSubview(mainLabel)
        self.view.addSubview(secondLabel)
        self.view.addSubview(collectionVItems)
        
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
        collectionVItems.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(secondLabel.snp.bottom).offset(20)
            make.bottom.equalToSuperview()
        }
        
    }
    // MARK: - UIFUNCTIONS


}
extension CategoryVC:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.data.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 //       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FavoriteCollectionVCell
            for (index, value) in vm.checkIndexPath.enumerated() {
                if value == vm.data[indexPath.row] {
                    vm.checkIndexPath.remove(at: index)
                    vm.checkIndex = true
                    break
                }
            }
            if  !vm.checkIndex {
                vm.checkIndexPath.append(vm.data[indexPath.row])
                collectionView.cellForItem(at: indexPath)?.contentView.backgroundColor = UIColor(named: "PurpleC")
  //              cell.mainText.textColor = .white
            } else {
                vm.checkIndex = false
                collectionView.cellForItem(at: indexPath)?.contentView.backgroundColor = UIColor(named: "textfield")
  //              cell.mainText.textColor = UIColor(named: "Grey")
            }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FavoriteCollectionVCell
        cell.mainText.text = vm.data[indexPath.row]
        return cell
    }
    
}
