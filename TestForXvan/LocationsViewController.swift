//
//  ViewController.swift
//  TestForXvan
//
//  Created by MacBook on 31.12.21.
//

import UIKit
import FirebaseStorage

class LocationsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var data: [UIImage] = [UIImage(named: "image1")!, UIImage(named: "image2")!, UIImage(named: "image3")!, UIImage(named: "image4")!, UIImage(named: "image5")!,  UIImage(named: "image6")!]
    
    private let storage = Storage.storage().reference()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "ЛОКАЦИИ"
        label.textColor = .black
        label.font = UIFont(name: "Oswald-Light", size: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let logoView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "XvanLogoImage")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 33
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 1
        view.layer.masksToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let subContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(cgColor: CGColor(red: 0.93, green: 0.95, blue: 0.96, alpha: 1.0))
        view.layer.cornerRadius = 23
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor(cgColor: CGColor(red: 0.93, green: 0.95, blue: 0.96, alpha: 1.0))
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let locationField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Название локации"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        return textField
    }()
    
    let addPictureButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var imagesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: subContainerView.frame, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(ImagesCollectionViewCell.self, forCellWithReuseIdentifier: ImagesCollectionViewCell.identifier)
        return collectionView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(cgColor: CGColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0))
        configureUI()
        addPictureButton.addTarget(self, action: #selector(addPictureAction), for: .touchUpInside)
    }
    
    @objc func didTapImageView(_ sender: UITapGestureRecognizer) {
        
    }
    //MARK: PickerAction
    @objc func addPictureAction() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        guard let imageData = image.pngData() else {
            return
        }
        
        storage.child("images/file.png").putData(imageData, metadata: nil, completion: { metadata, error in
            guard error == nil else {
                print("Failed to upload")
                return
            }
            
            self.storage.child("images/file.png").downloadURL { url, error in
                guard let url = url, error == nil else {
                    return
                }
                let urlString = url.absoluteString
                print("Downloaded url: \(urlString)")
                UserDefaults.standard.set(urlString, forKey: "url")
            }
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

private extension LocationsViewController {
    func configureUI() {
        //MARK: logoView constraints
        view.addSubview(logoView)
        logoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        logoView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        logoView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        
        //MARK: locationLabel constraints
        logoView.addSubview(locationLabel)
        locationLabel.centerXAnchor.constraint(equalTo: logoView.centerXAnchor).isActive = true
        locationLabel.centerYAnchor.constraint(equalTo: logoView.centerYAnchor).isActive = true
        
        //MARK: ConteinerView constraints
        view.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 30).isActive = true
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        
        //MARK: subContainerView constraints
        containerView.addSubview(subContainerView)
        subContainerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20).isActive = true
        subContainerView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        subContainerView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
        subContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20).isActive = true
        
        //MARK: stackView constraints
        subContainerView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: subContainerView.topAnchor, constant: 20).isActive = true
        stackView.leftAnchor.constraint(equalTo: subContainerView.leftAnchor, constant: 16).isActive = true
        stackView.rightAnchor.constraint(equalTo: subContainerView.rightAnchor, constant: -16).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //MARK: locationField constraints
        stackView.addSubview(locationField)
        locationField.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 5).isActive = true
        locationField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        
        //MARK: addPictureButton constraints
        stackView.addSubview(addPictureButton)
        addPictureButton.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -5).isActive = true
        
        //MARK: imagesCollectionView constraints
        subContainerView.addSubview(imagesCollectionView)
        imagesCollectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10).isActive = true
        imagesCollectionView.leadingAnchor.constraint(equalTo: subContainerView.leadingAnchor, constant: 16).isActive = true
        imagesCollectionView.trailingAnchor.constraint(equalTo: subContainerView.trailingAnchor, constant: -16).isActive = true
        imagesCollectionView.bottomAnchor.constraint(equalTo: subContainerView.bottomAnchor, constant: -10).isActive = true
        
    }
}

extension LocationsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesCollectionViewCell.identifier, for: indexPath)
        guard let imagesCell = cell as? ImagesCollectionViewCell else { return cell }
        imagesCell.imageView.image = data[indexPath.row]
        return imagesCell
    }
}
extension LocationsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 155, height: 155)
    }
    
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, minimumLineSpacingForSectionAt: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageFullScreenVC = FullScreenImageViewController()
        DispatchQueue.main.async {
            imageFullScreenVC.imageFullScreen.image = self.data[indexPath.row]
            self.navigationController?.pushViewController(imageFullScreenVC, animated: true)
        }
    }
}

extension LocationsViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(LocationsViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}



