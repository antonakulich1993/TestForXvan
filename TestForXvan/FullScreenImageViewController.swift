//
//  FullScreenImageViewController.swift
//  TestForXvan
//
//  Created by MacBook on 3.01.22.
//

import UIKit

class FullScreenImageViewController: UIViewController {
    
    var imageFullScreen: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        imageFullScreen.image = image
        view.addSubview(imageFullScreen)
        imageFullScreen.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageFullScreen.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageFullScreen.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        imageFullScreen.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
}
