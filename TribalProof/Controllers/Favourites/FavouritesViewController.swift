//
//  FavouritesViewController.swift
//  TribalWorldWideMitch
//
//  Created by Mitch Samaniego on 23/07/21.
//

import UIKit
import RealmSwift

class FavouritesViewController: UIViewController {
    
    private var feedCollectionView: UICollectionView?
    private var photos: [PhotoDB] = []
    var realm = try! Realm()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchPhotos()
    }
    
    func setupView() {
        
        let view = UIView()

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: self.view.frame.width, height: 320)
        
        feedCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        feedCollectionView?.register(FeedCell.self, forCellWithReuseIdentifier: FeedCell.identifier)
        feedCollectionView?.backgroundColor = UIColor.systemGray2
        view.addSubview(feedCollectionView ?? UICollectionView())
        
        feedCollectionView?.dataSource = self
        feedCollectionView?.delegate = self
        
        self.view = view
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    func fetchPhotos() {
        self.photos.removeAll()
        feedCollectionView?.reloadData()
        let favoritePhotos = try! realm.objects(PhotoDB.self)
        for photo in favoritePhotos {
            self.photos.append(photo)
            self.feedCollectionView?.reloadData()
        }
    }
    
}

extension FavouritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.identifier, for: indexPath) as! FeedCell
        cell.configWithDB(photos[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsView = ImageDetailViewController()
        NetworkManager.shared.getDetailsPhoto(id: photos[indexPath.row].id) { photo in
            detailsView.photo = photo
            self.navigationController?.pushViewController(detailsView, animated: true)
        }
    }
}


