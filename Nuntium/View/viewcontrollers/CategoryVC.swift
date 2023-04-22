//
//  CategoryVC.swift
//  Nuntium
//
//  Created by AziK's  MAC on 15.04.23.
//

import UIKit
public protocol SelectedCell {
    func changeTextColor()
    func changeBackgroundCell()
}
class CategoryVC: BaseViewController<CategoryViewModel> {
    var delegateCell : SelectedCell? = nil
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
        layout.minimumInteritemSpacing = 24
        layout.minimumLineSpacing = 24
        layout.itemSize = CGSize(width: (screenWidth - 64)/2, height: 70)
        view.delegate = self
        view.dataSource = self
        view.showsVerticalScrollIndicator = false
        view.register(FavoriteCollectionVCell.self, forCellWithReuseIdentifier: "cell")
        return view
    }()
    private lazy var saveBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Save", for: .normal)
        btn.backgroundColor = UIColor(named: "PurpleC")
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(onClickSaveBtn), for: .touchUpInside)
        return btn
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
        self.view.addSubview(saveBtn)
        
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
        saveBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.bottom.equalTo(self.view.snp.bottom).offset(-100)
            make.height.equalTo(48)
        }
        collectionVItems.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(secondLabel.snp.bottom).offset(20)
            make.bottom.equalTo(saveBtn.snp.top)
        }
    }
    // MARK: - UIFUNCTIONS
    @objc
    func onClickSaveBtn(){
        vm.request.addCategory(data: vm.selectedData).then { result in
            switch result {
            case .failure(let err):
                self.showAlert(message: err.localizedDescription, error: true)
            case .success(()):
                self.vm.selectedData = []
                self.showToast(message: "data succesfully saved")
            }
        }
    }

}
extension CategoryVC:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.data.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
         for (index, value) in vm.selectedData.enumerated() {
                if value == vm.data[indexPath.row] {
                    vm.selectedData.remove(at: index)
                    vm.checkIndex = false
                    break
                }
            }
            if  vm.checkIndex {
                vm.selectedData.append(vm.data[indexPath.row])
            } else {
                vm.checkIndex = true
            }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FavoriteCollectionVCell
        cell.collectionView = collectionView
        cell.mainText.text = vm.data[indexPath.row]
        return cell
    }
    
}
