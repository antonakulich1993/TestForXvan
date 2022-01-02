//
//  ViewController.swift
//  TestForXvan
//
//  Created by MacBook on 31.12.21.
//

import UIKit
import FirebaseStorage

class LocationsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let storage = Storage.storage().reference()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "ЛОКАЦИИ"
        label.font = UIFont(name: "Oswald-Light", size: 60)
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
        view.layer.shadowColor = UIColor(red: 0.38, green: 0.42, blue: 0.41, alpha: 0.17).cgColor
        view.layer.shadowOffset = CGSize(width: -10, height: 16)
        view.layer.shadowRadius = 20
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
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
    
    let image1: UIImageView = {
        let image = UIImageView(image: UIImage(named: "image1"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let image2: UIImageView = {
        let image = UIImageView(image: UIImage(named: "image2"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let image3: UIImageView = {
        let image = UIImageView(image: UIImage(named: "image3"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let image4: UIImageView = {
        let image = UIImageView(image: UIImage(named: "image4"))
        image.image = UIImage(named: "image4")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let image5: UIImageView = {
        let image = UIImageView(image: UIImage(named: "image5"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let image6: UIImageView = {
        let image = UIImageView(image: UIImage(named: "image6"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(cgColor: CGColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0))
        configureUI()
        addPictureButton.addTarget(self, action: #selector(addPictureAction), for: .touchUpInside)
    }
    
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
        view.addSubview(logoView)
        
        //MARK: logoView constraints
        logoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        logoView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        logoView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        logoView.widthAnchor.constraint(equalToConstant: 465).isActive = true
        
        
        //MARK: locationLabel constraints
        logoView.addSubview(locationLabel)
        locationLabel.centerXAnchor.constraint(equalTo: logoView.centerXAnchor).isActive = true
        locationLabel.centerYAnchor.constraint(equalTo: logoView.centerYAnchor).isActive = true
        
        view.addSubview(containerView)
        
        containerView.addSubview(subContainerView)
        
        //MARK: ConteinerView constraints
        containerView.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 30).isActive = true
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 615).isActive = true
        
        //MARK: subContainerView constraints
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
        
        //MARK: AllImages Constraints
        subContainerView.addSubview(image1)
        image1.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15).isActive = true
        image1.leftAnchor.constraint(equalTo: subContainerView.leftAnchor, constant: 20).isActive = true
        image1.widthAnchor.constraint(equalToConstant: 150).isActive = true
        image1.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        subContainerView.addSubview(image2)
        image2.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15).isActive = true
        image2.rightAnchor.constraint(equalTo: subContainerView.rightAnchor, constant: -20).isActive = true
        image2.widthAnchor.constraint(equalToConstant: 150).isActive = true
        image2.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        subContainerView.addSubview(image3)
        image3.topAnchor.constraint(equalTo: image1.bottomAnchor, constant: 16).isActive = true
        image3.leftAnchor.constraint(equalTo: subContainerView.leftAnchor, constant: 20).isActive = true
        image3.widthAnchor.constraint(equalToConstant: 150).isActive = true
        image3.heightAnchor.constraint(equalToConstant: 150).isActive = true

        subContainerView.addSubview(image4)
        image4.topAnchor.constraint(equalTo: image2.bottomAnchor, constant: 16).isActive = true
        image4.rightAnchor.constraint(equalTo: subContainerView.rightAnchor, constant: -20).isActive = true
        image4.widthAnchor.constraint(equalToConstant: 150).isActive = true
        image4.heightAnchor.constraint(equalToConstant: 150).isActive = true

        subContainerView.addSubview(image5)
        image5.topAnchor.constraint(equalTo: image3.bottomAnchor, constant: 16).isActive = true
        image5.leftAnchor.constraint(equalTo: subContainerView.leftAnchor, constant: 20).isActive = true
        image5.widthAnchor.constraint(equalToConstant: 150).isActive = true
        image5.heightAnchor.constraint(equalToConstant: 150).isActive = true

        subContainerView.addSubview(image6)
        image6.topAnchor.constraint(equalTo: image4.bottomAnchor, constant: 16).isActive = true
        image6.rightAnchor.constraint(equalTo: subContainerView.rightAnchor, constant: -20).isActive = true
        image6.widthAnchor.constraint(equalToConstant: 150).isActive = true
        image6.heightAnchor.constraint(equalToConstant: 150).isActive = true
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



