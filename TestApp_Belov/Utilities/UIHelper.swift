//
//  UIHelper.swift
//  TestApp_Belov
//
//  Created by Владислав Белов on 29.09.2021.
//

import Foundation
import UIKit

enum UIHelper{
    
    static func createFlowLayout(in view: UIView) -> UICollectionViewFlowLayout{
        let width                       = view.bounds.width
        let padding: CGFloat            = 10
        let availableWidth              = width
        let itemWidth                   = availableWidth
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth)
        
        return flowLayout
    }
}
