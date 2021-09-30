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
        
        clipsToBounds = true
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor)
        ])
    }
    
    override var isSelected: Bool{
           didSet{
               UIView.animate(withDuration: 0.3) {
                   self.photoImageView.transform = self.isSelected ? CGAffineTransform(translationX: 400, y: 0) : CGAffineTransform.identity
               }
           }
       }
    
    
    func set(image: Hit){
        photoImageView.downloadImage(fromURL: image.largeImageURL)
        }
    
    
}
