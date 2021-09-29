//
//  PhotoCollectionViewCell.swift
//  TestApp_Belov
//
//  Created by Владислав Белов on 29.09.2021.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    static let reuseID = "PhotoCell"
    let photoImageView = PhotoImageView(frame: .zero)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configure(){
        addSubview(photoImageView)
        photoImageView.contentMode = .scaleAspectFit
        photoImageView.sizeToFit()
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor)
        ])
    }
    
    
    func set(image: Hit){
        photoImageView.downloadImage(fromURL: image.largeImageURL)
        }
    
    
}
