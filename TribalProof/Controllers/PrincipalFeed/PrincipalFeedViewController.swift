//
//  PrincipalFeedViewController.swift
//  TribalWorldWideMitch
//
//  Created by Mitch Samaniego on 23/07/21.
//

import UIKit

class PrincipalFeedViewController: UIViewController {
    
    private var feedCollectionView: UICollectionView?
    private var photos: [Photo] = []
    var currentPage : Int = 1
    var isLoadingList : Bool = false

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
        
        feedCollectionView?.refreshControl = UIRefreshControl()
        feedCollectionView?.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc func refreshData() {
        fetchPhotos()
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    func fetchPhotos() {
        NetworkManager.shared.getPhotos(page: currentPage) { photos in
            self.photos = photos
            self.feedCollectionView?.reloadData()
            self.feedCollectionView?.refreshControl?.endRefreshing()
        }
    }
    
    func fetchMorePhotos() {
        NetworkManager.shared.getPhotos(page: currentPage) { photos in
            self.photos.append(contentsOf: photos)
            self.feedCollectionView?.reloadData()
        }
    }
}

extension PrincipalFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.identifier, for: indexPath) as! FeedCell
        cell.configWith(photos[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsView = ImageDetailViewController()
        NetworkManager.shared.getDetailsPhoto(id: photos[indexPath.row].id!) { photo in
            detailsView.photo = photo
            self.navigationController?.pushViewController(detailsView, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if photos.count == indexPath.row + 1 {
            currentPage += 1
            fetchMorePhotos()
        }
    }
}
