//
//  PhotoImageView.swift
//  TestApp_Belov
//
//  Created by Владислав Белов on 29.09.2021.
//

import UIKit

class PhotoImageView: UIImageView {
    
    let cache            = NetworkManager.shared.cache
    let placeholderImage = UIImage(named: "placeholder")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        contentMode         = .scaleAspectFill
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(fromURL url: String){
        let cacheKey = NSString(string: url)
        if let image = cache.object(forKey: NSString(string: cacheKey)){
            self.image = image
            return
        }
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            guard let image = image else { return }
            self.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
