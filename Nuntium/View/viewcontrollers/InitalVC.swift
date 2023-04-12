//
//  InitalVC.swift
//  Nuntium
//
//  Created by AziK's  MAC on 12.04.23.
//

import UIKit
import SnapKit

class InitalVC: BaseViewController<InitialViewModel> {
    //MARK: CLOSURES
    private lazy var segmentC:UISegmentedControl = {
        let segmentC = UISegmentedControl(items: vm.dataImage)
        segmentC.selectedSegmentIndex = 1
        segmentC.tintColor = .white
        return segmentC
    }()
    private lazy var collectionV:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: 250, height: 300)
        view.delegate = self
        view.dataSource = self
        view.register(InitialCollectionVCell.self, forCellWithReuseIdentifier: "cell")
        return view
    }()
    private lazy var nextBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Next", for: .normal)
        btn.backgroundColor = UIColor(named: "PurpleC")
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(onClickNext), for: .touchUpInside)
        return btn
    }()
    //MARK: VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    //MARK: FUNCTIONS
    private func setup(){
        
        let mainLabel = UILabel()
        mainLabel.text = "First to know"
        mainLabel.textColor = .black
        mainLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        
        let secondLabel = UILabel()
        secondLabel.text = "All news in one place, be the first to know last news"
        secondLabel.textColor = UIColor(named:"Grey")
        secondLabel.numberOfLines = 0
        secondLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        
        self.view.backgroundColor = .white
        self.view.addSubview(nextBtn)
        self.view.addSubview(collectionV)
        self.view.addSubview(segmentC)
        self.view.addSubview(mainLabel)
        self.view.addSubview(secondLabel)
        
        collectionV.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.height.equalTo(300)
        }
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(collectionV.snp.bottom).offset(60)
        }
        secondLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(75)
            make.right.equalToSuperview().offset(-70)
            make.bottom.equalTo(mainLabel.snp.bottom).offset(24)
        }
        nextBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-40)
            make.height.equalTo(48)
        }
    }
    
    //MARK: UIFUNCTIONS
    @objc func onClickNext(){
        navigationController?.viewControllers = [router.getStartedVC()]
    }
}
extension InitalVC:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.dataImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InitialCollectionVCell
        cell.icon.image = vm.dataImage[indexPath.row]
        return cell
    }
    
    
}
