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
        text.numberOfLines = 0
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
        text.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        text.textColor = UIColor(named: "Grey")
        text.text = "Content:"
        return text
    }()
    private lazy var resultLabel: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        text.textColor = UIColor(named: "Grey")
        text.numberOfLines = 0
        text.text = "Sorry,there is no content about it"
        return text
    }()
    private lazy var shareBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "share"), for: .normal)
        btn.addTarget(self, action: #selector(onClickShare), for: .touchUpInside)
        return btn
    }()
    private lazy var viewBottom: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var commentsCV:UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.itemSize = CGSize(width: screenWidth, height: 40)
        let view = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.showsVerticalScrollIndicator = false
        view.register(CommentCVCell.self, forCellWithReuseIdentifier: "cell")
        return view
    }()
    private lazy var profilePhoto:UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 24
        image.layer.masksToBounds = true
        return image
    }()
    private lazy var commentTF:UITextField = {
        let tf = UITextField()
        tf.autocorrectionType = .no
        tf.setLeftPaddingPoints(10)
        tf.layer.cornerRadius = 8
        tf.backgroundColor = UIColor(named: "textfield")
        tf.placeholder = "Add comment"
        return tf
    }()
    private lazy var commentLabel: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        text.textColor = UIColor(named: "Grey")
        text.text = "Comment:"
        return text
    }()
    private lazy var addComment:UIButton = {
        let btn = UIButton()
        btn.setTitle("Post", for: .normal)
        btn.backgroundColor = UIColor(named: "PurpleC")
        btn.layer.cornerRadius = 16
        btn.addTarget(self, action: #selector(onClickPost), for: .touchUpInside)
        return btn
    }()
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.getComment().then { result in
            switch result {
            case .success(let data):
                self.vm.comments = data
                self.commentsCV.reloadData()
            case .failure(let err):
                self.showAlert(message: err.localizedDescription, error: true)
            }
            self.commentLabel.text = "Comment : \(self.vm.comments.count)"
        }
        setData()
        setup()
    }
    // MARK: - Functions
    private func getProfileImage() {
        vm.requestStorage.getProfilePhoto().then { result in
            switch result {
            case .success(let image):
                self.profilePhoto.image = image
            case .failure(_):
                self.profilePhoto.image = UIImage(named: "noUser")
            }

        }
    }
    private func setData(){
        getProfileImage()
        
        DispatchQueue.main.async {
            if self.vm.data.content != nil || self.vm.data.content != "" {
                self.titleLabel.text = self.vm.data.description
                self.typeLabel.text = self.vm.data.source.name
                self.resultLabel.text = self.vm.data.content
            } else {
                self.titleLabel.text = self.vm.data.title
                self.typeLabel.text = self.vm.data.source.name
                self.resultLabel.text = "Sorry,there is no content about it"
            }
        }
        if self.vm.data.urlToImage == nil {
            backImage.image = UIImage(named: "noImage")
        } else {
            let url = URL(string: vm.data.urlToImage!)!

            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
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
    }
    private func setup(){
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.setRightBarButton(UIBarButtonItem(title: "", image:UIImage(named: "save"),  target: self, action: #selector(onClickRightBtnNav)), animated: true)
        
        self.view.backgroundColor = .white
        self.view.addSubview(backImage)
        self.backImage.addSubview(titleLabel)
        self.backImage.addSubview(viewBack)
        self.view.addSubview(shareBtn)
        self.view.addSubview(viewBottom)
        self.viewBottom.addSubview(contentLabel)
        self.viewBottom.addSubview(resultLabel)
        self.viewBottom.addSubview(commentsCV)
        
        self.viewBottom.addSubview(profilePhoto)
        self.viewBottom.addSubview(commentTF)
        self.viewBottom.addSubview(addComment)
        self.viewBottom.addSubview(commentLabel)

        backImage.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(self.view.snp.centerY)
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
        viewBack.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalTo(self.titleLabel.snp.top).offset(-8)
            if vm.data.source.name!.count <= 4 {
                make.width.equalTo(vm.data.source.name!.count*12)
            } else {
                make.width.equalTo(vm.data.source.name!.count*10)
            }
            make.height.equalTo(24)
        }
        shareBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-13)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
        }
        viewBottom.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.view.snp.centerY).offset(-20)
        }
        contentLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(16)
        }
        resultLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(self.contentLabel.snp.bottom).offset(3)
        }
        commentLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(resultLabel.snp.bottom).offset(8)
        }
        profilePhoto.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.width.height.equalTo(48)
        }
        addComment.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(48)
            make.width.equalTo(72)
        }
        commentTF.snp.makeConstraints { make in
            make.left.equalTo(profilePhoto.snp.right)
            make.right.equalTo(addComment.snp.left)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(48)
        }
        commentsCV.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.commentLabel.snp.bottom).offset(8)
            make.bottom.equalTo(addComment.snp.top).offset(-8)
        }

    }
    // MARK: - UIFunctions
    @objc
    func onClickPost(){
        if commentTF.text == "" {
            self.showAlert(message: "Fill comment!", error: true)
        } else {
            let data = CommentModel(image: (profilePhoto.image ?? UIImage(named: "noUser"))!, name: vm.requestAuth.name!, comment: commentTF.text!)
            vm.requestDB.addComment(data: data, key: (vm.data.title ?? "noTitle")+(vm.data.source.name ?? "noUser")).then { result in
                switch result {
                case .failure(_):
                    break
                case .success(()):
                    self.vm.comments.insert(data, at: 0)
                    self.commentsCV.reloadData()
                    self.showToast(message: "comment posted")
                    self.commentLabel.text = "Comment : \(self.vm.comments.count)"
                }
            }
            commentTF.text = ""
        }
    }
    @objc
    func onClickShare(){
        if let url = URL(string: vm.data.url!) {
            let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            if let popoverPresentationController = activityViewController.popoverPresentationController {
                popoverPresentationController.sourceView = self.view
                popoverPresentationController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverPresentationController.permittedArrowDirections = []
            }
            self.present(activityViewController, animated: true, completion: nil)
        }
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
extension NewsDidSelect:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CommentCVCell
        cell.image.image = vm.comments[indexPath.row].image
        cell.name.text = vm.comments[indexPath.row].name
        cell.comment.text = vm.comments[indexPath.row].comment
        return cell
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
