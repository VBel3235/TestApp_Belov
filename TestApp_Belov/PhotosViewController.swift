//
//  PhotosViewController.swift
//  TestApp_Belov
//
//  Created by Владислав Белов on 29.09.2021.
//

import UIKit

class PhotosViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavigationController()
    }
    
    func configureView(){
        view.backgroundColor = .systemBackground
    }
    
    func configureNavigationController(){
        self.navigationItem.title = "Фотографии"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }


}
