//
//  PhotosViewController.swift
//  TestApp_Belov
//
//  Created by Владислав Белов on 29.09.2021.
//

import UIKit

class PhotosViewController: VBViewController {
    
    enum Section{
        case main
        
    }
    
    var images: [Hit] = []
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Hit>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavigationController()
        configureCollectionView()
        configureDataSource()
    }
    
    func configureView(){
        view.backgroundColor = .systemBackground
    }
    
    func configureNavigationController(){
        self.navigationItem.title = "Фотографии"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPhotos()
    }
    
    func getPhotos(){
        self.showLoadingView()
        NetworkManager.shared.getPhotos { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result{
            case .success(let data):
                self.images = data.hits
                print(self.images)
                self.updateDate()
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func createFlowLayout() -> UICollectionViewFlowLayout{
        let width                       = view.bounds.width
        let padding: CGFloat            = 0
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth / 2
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }

    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createFlowLayout())
        view.addSubview(collectionView)
       
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseID)
    }

    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Hit>(collectionView: collectionView, cellProvider: { collectionView, indexPath, image in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseID, for: indexPath) as? PhotoCollectionViewCell
            cell?.set(image: image)
            return cell
        })
    }
    
    func updateDate(){
        var snapShot = NSDiffableDataSourceSnapshot<Section, Hit>()
        snapShot.appendSections([.main])
        snapShot.appendItems(images, toSection: .main)
        DispatchQueue.main.async {
            self.dataSource.apply(snapShot, animatingDifferences: true)
        }
       
        
    }
}
