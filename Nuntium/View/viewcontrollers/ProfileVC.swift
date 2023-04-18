//
//  ProfileVC.swift
//  Nuntium
//
//  Created by AziK's  MAC on 15.04.23.
//

import UIKit

class ProfileVC: BaseViewController<ProfileViewModel> {

    private lazy var mainLabel:UILabel = {
        let text = UILabel()
        text.text = "Profile"
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return text
    }()
    private lazy var profileImage:UIImageView = {
        let icon = UIImageView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(onClickProfileImage(_:)))
        icon.isUserInteractionEnabled = true
        icon.addGestureRecognizer(tap)
        icon.image = vm.profileImage
        icon.layer.cornerRadius = 36
        icon.layer.masksToBounds = true
        return icon
    }()
    private lazy var fullNameLabel:UILabel = {
        let text = UILabel()
        text.text = vm.fullName
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return text
    }()
    private lazy var gmailLabel:UILabel = {
        let text = UILabel()
        text.text = vm.gmail
        text.textColor = UIColor(named:"Grey")
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return text
    }()
    private lazy var colletionV:UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.itemSize = CGSize(width: screenWidth-40, height: 56)
        let view = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.showsVerticalScrollIndicator = false
        view.register(ProfileCollectioVCell.self, forCellWithReuseIdentifier: "cell")
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    // MARK: - FUNCTIONS
    private func getImage(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true)
    }
    private func showSuggestProfileImage() {
        var alert:UIAlertController
        alert = UIAlertController(title: "Do you want to add or change profile image?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default,handler: { _ in
            self.getImage()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel))
            self.present(alert, animated: true, completion: nil)
        }
    private func showSuggest() {
        var alert:UIAlertController
        alert = UIAlertController(title: "Choose one of them", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "delete", style: .default,handler: { _ in
            self.vm.deleteUser().then { result in
                switch result {
                case .success(()):
                    self.navigationController?.viewControllers = [self.router.loginVC()]
                case .failure(let err):
                    self.showAlert(message: err.localizedDescription, error: true)
                }
                }
        }))
        alert.addAction(UIAlertAction(title: "sign out", style: .default,handler: { _ in
            self.vm.signout().then { result in
                switch result {
                case .success(()):
                    self.navigationController?.viewControllers = [self.router.loginVC()]
                case .failure(let err):
                    self.showAlert(message: err.localizedDescription, error: true)
                }
            }
        }))
            self.present(alert, animated: true, completion: nil)
        }
    private func setup(){
        self.view.backgroundColor = .white
        self.view.addSubview(mainLabel)
        self.view.addSubview(fullNameLabel)
        self.view.addSubview(gmailLabel)
        self.view.addSubview(profileImage)
        self.view.addSubview(colletionV)
        
        mainLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        profileImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(mainLabel.snp.bottom).offset(30)
            make.width.height.equalTo(72)
        }
        fullNameLabel.snp.makeConstraints { make in
            make.left.equalTo(profileImage.snp.right).offset(8)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalTo(profileImage.snp.centerY).offset(-10)
        }
        gmailLabel.snp.makeConstraints { make in
            make.left.equalTo(profileImage.snp.right).offset(8)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(fullNameLabel.snp.bottom).offset(6)
        }
        colletionV.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(profileImage.snp.bottom).offset(16)
            make.bottom.equalToSuperview()
        }
        
    }
    // MARK: - UIFUNCTIONS
    @objc
    func onClickProfileImage(_ sender:UITapGestureRecognizer){
        self.showSuggestProfileImage()
    }
    @objc
    func onClickButton(_ sender:UIButton){
        let position = sender.convert(CGPoint.zero, to: colletionV)
        guard let index = colletionV.indexPathForItem(at: position) else {return}
        switch vm.data[index.row].title {
        case "Change Password":
            navigationItem.title = ""
            navigationController?.pushViewController(router.changePasswordVC(), animated: true)
        case "Language":
            navigationItem.title = ""
            navigationController?.pushViewController(router.languageVC(), animated: true)
        case "Terms & Conditions":
            navigationItem.title = ""
            navigationController?.pushViewController(router.termsVC(), animated: true)
        case "About":
            navigationItem.title = ""
            navigationController?.pushViewController(router.aboutUsVC(), animated: true)
        default:
            self.showSuggest()
        }
    }
    @objc
    func onClickSwitch(){
        vm.checkSwitch.toggle()
        self.showToast(message: "notification- \(vm.checkSwitch)")
    }

}
extension ProfileVC:UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    //MARK: UIMAGEPICKER FUNCTIONS
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage,
              let imageData = image.jpegData(compressionQuality: 0.75) else {
            return
        }
        vm.addOrUpdateProfilePhoto(data: imageData).then { result in
            switch result {
            case .success(()):
                // refresh profile photo
                self.showToast(message: "Profile photo is saved succussfully")
            case .failure(let err):
                print(err.localizedDescription)
                self.showAlert(message: err.localizedDescription, error: true)
            }
        }
    }
    
    //MARK: COLLECTIONVIEW FUNCTIONS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProfileCollectioVCell
        cell.title.text = vm.data[indexPath.row].title
        if vm.data[indexPath.row].title == "Notifications" {
            cell.switchBtnsetup()
            cell.switchButton.addTarget(self, action: #selector(onClickSwitch), for: .valueChanged)
        } else {
            cell.button.setImage(vm.data[indexPath.row].icon, for: .normal)
            cell.button.tag = indexPath.row
            cell.button.addTarget(self, action: #selector(onClickButton(_:)), for: .touchUpInside)
        }
        return cell
    }
    
}
