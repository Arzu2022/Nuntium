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
    private var pageControl = UIPageControl()
        
    private lazy var collectionV:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 300, height: 300)
        let view = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.showsHorizontalScrollIndicator = false
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
        self.view.addSubview(pageControl)
        self.view.addSubview(mainLabel)
        self.view.addSubview(secondLabel)
        
        pageControl.center = view.center
        pageControl.numberOfPages = vm.dataImage.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = UIColor(named: "PurpleC")
        pageControl.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
        
        
        collectionV.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.height.equalTo(300)
        }
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.collectionV.snp.bottom).offset(20)
        }
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pageControl.snp.bottom).offset(20)
        }
        secondLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(75)
            make.right.equalToSuperview().offset(-70)
            make.top.equalTo(mainLabel.snp.bottom).offset(24)
        }
        nextBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-40)
            make.height.equalTo(48)
        }
    }
    
    //MARK: UIFUNCTIONS
    @objc func pageControlValueChanged(sender: UIPageControl) {
        
        let indexPath = IndexPath(item: sender.currentPage, section: 0)
        self.collectionV.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
        
    }
    
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let currentIndex = Int(scrollView.contentOffset.x / (collectionV.frame.size.width/2))
            pageControl.currentPage = currentIndex
        }
    
}
