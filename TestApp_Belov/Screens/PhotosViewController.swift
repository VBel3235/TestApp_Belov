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
    
    var snapShot = NSDiffableDataSourceSnapshot<Section, Hit>()

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
                self.updateData()
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
   

    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createFlowLayout(in: view))
        collectionView.isUserInteractionEnabled = true
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseID)
    }
    
    @objc func refresh(){
        images.removeAll()
        getPhotos()
        
        DispatchQueue.main.async {
            self.collectionView.refreshControl?.endRefreshing()
        }
    }

    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Hit>(collectionView: collectionView, cellProvider: { collectionView, indexPath, image in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseID, for: indexPath) as? PhotoCollectionViewCell
            cell?.set(image: image)
            
            return cell
        })
    }
    
    func updateData(){
        if snapShot.numberOfSections == 0{
            snapShot.appendSections([.main])
        }
        snapShot.appendItems(images, toSection: .main)
        DispatchQueue.main.async {
            self.dataSource.apply(self.snapShot, animatingDifferences: true)
        }
    }
        func deleteData(indexPath: IndexPath){
            
              guard let item = dataSource.itemIdentifier(for: indexPath) else {
                  return
              }
              snapShot.deleteItems([item])
            dataSource.apply(snapShot, animatingDifferences: true
                               , completion: nil)
        }
    
}

extension PhotosViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.32){
            self.deleteData(indexPath: indexPath)
        }
        
}
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        true
    }
    
}
