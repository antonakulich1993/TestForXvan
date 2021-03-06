//
//  ImagesCollectionViewCell.swift
//  TestForXvan
//
//  Created by MacBook on 3.01.22.
//

import UIKit

class ImagesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ImagesCollectionViewCell"
    
    var imageView: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 22
        contentView.layer.masksToBounds = true
        contentView.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


