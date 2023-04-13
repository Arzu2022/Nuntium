//
//  FavoriteTopicVC.swift
//  Nuntium
//
//  Created by AziK's  MAC on 13.04.23.
//

import UIKit

class FavoriteTopicVC: BaseViewController<FavoriteTopicViewModel> {
    private lazy var mainLabel:UILabel = {
        let text = UILabel()
        text.text = "Select your favorite topics"
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return text
    }()
    private lazy var secondLabel:UILabel = {
        let text = UILabel()
        text.text = "Select some of your favorite topics to let us suggest better news for you."
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
        view.showsHorizontalScrollIndicator = false
        view.register(FavoriteCollectionVCell.self, forCellWithReuseIdentifier: "cell")
        return view
    }()
    private lazy var nextBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Next", for: .normal)
        btn.backgroundColor = UIColor(named: "PurpleC")
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(onClickNextBtn), for: .touchUpInside)
        return btn
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
        self.view.addSubview(collectionVItems)
        self.view.addSubview(nextBtn)
        
        mainLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        secondLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(mainLabel.snp.bottom).offset(8)
        }
        nextBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.bottom.equalTo(self.view.snp.bottom).offset(-40)
            make.height.equalTo(48)
        }
        collectionVItems.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(secondLabel.snp.bottom).offset(20)
            make.bottom.equalTo(nextBtn.snp.top)
        }
        
    }
    //MARK: UIFUNCTIONS
    @objc
    func onClickNextBtn(){
        navigationController?.viewControllers = [TabBar()]
    }
}
extension FavoriteTopicVC:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.data.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
            } else {
                vm.checkIndex = false
                collectionView.cellForItem(at: indexPath)?.contentView.backgroundColor = UIColor(named: "textfield")
            }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FavoriteCollectionVCell
        cell.isUserInteractionEnabled = true
        cell.mainText.text = vm.data[indexPath.row]
        return cell
    }
    
}
