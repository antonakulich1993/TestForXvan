//
//  ViewController.swift
//  TestForXvan
//
//  Created by MacBook on 31.12.21.
//

import UIKit

class LocationsViewController: UIViewController {
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "ЛОКАЦИИ"
        label.font = UIFont(name: "Oswald", size: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let logoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(patternImage: UIImage(named: "XvanLogoImage")!)
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 33
        view.layer.shadowColor = CGColor(red: 0.38, green: 0.42, blue: 0.41, alpha: 0.17)
        view.layer.shadowOffset = CGSize(width: 50, height: 50)
        view.layer.shadowRadius = 8
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
        stackView.spacing = 13
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = UIColor(cgColor: CGColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0))
        view.addSubview(logoView)
        
        view.addSubview(containerView)
        
        containerView.addSubview(subContainerView)
                
        //MARK: locationLabel constraints
        logoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 89).isActive = true
        logoView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        logoView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        logoView.widthAnchor.constraint(equalToConstant: 465).isActive = true
        
        logoView.addSubview(locationLabel)
        locationLabel.centerXAnchor.constraint(equalTo: logoView.centerXAnchor).isActive = true
        locationLabel.centerYAnchor.constraint(equalTo: logoView.centerYAnchor).isActive = true
        
        
        //MARK: ConteinerView constraints
        containerView.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 71).isActive = true
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 615).isActive = true
        
        //MARK: subContainerView constraints
        subContainerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32).isActive = true
        subContainerView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 30).isActive = true
        subContainerView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -30).isActive = true
        subContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -33).isActive = true
        
        //MARK: stackView constraints
        
        subContainerView.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: subContainerView.topAnchor, constant: 27).isActive = true
        stackView.leftAnchor.constraint(equalTo: subContainerView.leftAnchor, constant: 18).isActive = true
        stackView.rightAnchor.constraint(equalTo: subContainerView.rightAnchor, constant: -20).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //MARK: locationField constraints
        stackView.addSubview(locationField)
        locationField.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 5).isActive = true
        
        
        //MARK: addPictureButton constraints
        stackView.addSubview(addPictureButton)
        addPictureButton.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -5).isActive = true
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

