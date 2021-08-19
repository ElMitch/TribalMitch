//
//  ProfileViewController.swift
//  TribalWorldWideMitch
//
//  Created by Mitch Samaniego on 23/07/21.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController {
     
    private let scrollView = UIScrollView()
    private let backButton = UIButton()
    
    private let viewOfProfileImage = UIView()
    private let imageOfProfile = UIImageView()
    
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    private let messageButton = UIButton()
    private let followButton = UIButton()
    
    private let countOfPhotos = UILabel()
    private let photosLabel = UILabel()
    private let countOfCollection = UILabel()
    private let collectionLabel = UILabel()
    private let countOfLikes = UILabel()
    private let likesLabel = UILabel()
    
    private let gpsImage = UIImageView()
    private let locationLabel = UILabel()
    
    private let faceIcon = UIImageView()
    private let twitterIcon = UIImageView()
    private let linkedInIcon = UIImageView()
    private let instagramIcon = UIImageView()
    
    private let photoSectionTitle = UILabel()
    private let moreButton = UIButton()
    private var photosCollection: UICollectionView!
    private let photosCollectionContainer = UIView()
    
    private let collectionsSectionTitle = UILabel()
    private let allButton = UIButton()
    private var collectionsCollection: UICollectionView!
    private let collectionsCollectionContainer = UIView()
    
    var user: User?
    private var collections: [Collections] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupContent()
        fetchCollections()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        let contentGuide = scrollView.contentLayoutGuide
        let frameGuide = scrollView.frameLayoutGuide
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 150)
        
        photosCollection = UICollectionView(frame: self.photosCollectionContainer.frame, collectionViewLayout: layout)
        collectionsCollection = UICollectionView(frame: self.collectionsCollectionContainer.frame, collectionViewLayout: layout)
        
        photosCollection?.register(PhotosAndCollectionsCell.self, forCellWithReuseIdentifier: PhotosAndCollectionsCell.identifier)
        collectionsCollection?.register(PhotosAndCollectionsCell.self, forCellWithReuseIdentifier: PhotosAndCollectionsCell.identifier)
        
        photosCollection.translatesAutoresizingMaskIntoConstraints = false
        collectionsCollection.translatesAutoresizingMaskIntoConstraints = false
        
        photosCollection.tag = 101
        collectionsCollection.tag = 102
        
        photosCollection.showsVerticalScrollIndicator = false
        collectionsCollection.showsVerticalScrollIndicator = false
        
        photosCollection.backgroundColor = .clear
        collectionsCollection.backgroundColor = .clear
        
        photosCollection.delegate = self
        photosCollection.dataSource = self
        
        collectionsCollection.delegate = self
        collectionsCollection.dataSource = self
        
        collectionsCollectionContainer.addSubview(collectionsCollection)
        photosCollectionContainer.addSubview(photosCollection)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        viewOfProfileImage.translatesAutoresizingMaskIntoConstraints = false
        imageOfProfile.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.isUserInteractionEnabled = true
        
        nameLabel.numberOfLines = 0
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        
        view.addSubview(scrollView)
        scrollView.addSubview(backButton)
        scrollView.addSubview(viewOfProfileImage)
        viewOfProfileImage.addSubview(imageOfProfile)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(descriptionLabel)
        
        let buttonsStackView = UIStackView(arrangedSubviews: [messageButton, followButton])
        buttonsStackView.axis = .horizontal
        buttonsStackView.distribution = .fill
        buttonsStackView.alignment = .center
        buttonsStackView.spacing = 15
        
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(buttonsStackView)
        
        let photosStackView = UIStackView(arrangedSubviews: [countOfPhotos, photosLabel])
        photosStackView.axis = .vertical
        photosStackView.distribution = .fill
        photosStackView.alignment = .center
        photosStackView.spacing = 10
        
        let collectionsStackView = UIStackView(arrangedSubviews: [countOfCollection, collectionLabel])
        collectionsStackView.axis = .vertical
        collectionsStackView.distribution = .fill
        collectionsStackView.alignment = .center
        collectionsStackView.spacing = 10
        
        let likesStackView = UIStackView(arrangedSubviews: [countOfLikes, likesLabel])
        likesStackView.axis = .vertical
        likesStackView.distribution = .fill
        likesStackView.alignment = .center
        likesStackView.spacing = 10
        
        let stadisticsStackView = UIStackView(arrangedSubviews: [photosStackView, collectionsStackView, likesStackView])
        stadisticsStackView.axis = .horizontal
        stadisticsStackView.distribution = .fillEqually
        stadisticsStackView.alignment = .center
        stadisticsStackView.spacing = 15
        
        stadisticsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stadisticsStackView)
        
        let locationStackView = UIStackView(arrangedSubviews: [gpsImage, locationLabel])
        locationStackView.axis = .horizontal
        locationStackView.distribution = .fill
        locationStackView.alignment = .center
        locationStackView.spacing = 15
        
        locationStackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(locationStackView)
        
        let socialMediaStackView = UIStackView(arrangedSubviews: [faceIcon, twitterIcon, linkedInIcon, instagramIcon])
        socialMediaStackView.axis = .horizontal
        socialMediaStackView.distribution = .fill
        socialMediaStackView.alignment = .center
        socialMediaStackView.spacing = 30
        
        socialMediaStackView.translatesAutoresizingMaskIntoConstraints = false
        photoSectionTitle.translatesAutoresizingMaskIntoConstraints = false
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        photosCollectionContainer.translatesAutoresizingMaskIntoConstraints = false
        collectionsSectionTitle.translatesAutoresizingMaskIntoConstraints = false
        allButton.translatesAutoresizingMaskIntoConstraints = false
        collectionsCollectionContainer.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(socialMediaStackView)
        scrollView.addSubview(photoSectionTitle)
        scrollView.addSubview(moreButton)
        scrollView.addSubview(photosCollectionContainer)
        scrollView.addSubview(collectionsSectionTitle)
        scrollView.addSubview(allButton)
        scrollView.addSubview(collectionsCollectionContainer)
        
        
        
        NSLayoutConstraint.activate([
        
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            backButton.topAnchor.constraint(equalTo: contentGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: frameGuide.leadingAnchor, constant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 35),
            backButton.widthAnchor.constraint(equalToConstant: 35),
            
            viewOfProfileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            viewOfProfileImage.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 5),
            viewOfProfileImage.widthAnchor.constraint(equalToConstant: view.frame.width * 0.25),
            viewOfProfileImage.heightAnchor.constraint(equalToConstant: view.frame.width * 0.25),
            
            imageOfProfile.topAnchor.constraint(equalTo: viewOfProfileImage.topAnchor, constant: 0),
            imageOfProfile.leadingAnchor.constraint(equalTo: viewOfProfileImage.leadingAnchor, constant: 0),
            imageOfProfile.trailingAnchor.constraint(equalTo: viewOfProfileImage.trailingAnchor, constant: 0),
            imageOfProfile.bottomAnchor.constraint(equalTo: viewOfProfileImage.bottomAnchor, constant: 0),
            
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            nameLabel.topAnchor.constraint(equalTo: viewOfProfileImage.bottomAnchor, constant: 15),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: frameGuide.leadingAnchor, constant: 40),
            descriptionLabel.trailingAnchor.constraint(equalTo: frameGuide.trailingAnchor, constant: -40),
            
            buttonsStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15),
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
            messageButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.3),
            followButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.3),
            
            messageButton.heightAnchor.constraint(equalToConstant: view.frame.width * 0.1),
            followButton.heightAnchor.constraint(equalToConstant: view.frame.width * 0.1),
            
            stadisticsStackView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 20),
            stadisticsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            stadisticsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            locationStackView.topAnchor.constraint(equalTo: stadisticsStackView.bottomAnchor, constant: 20),
            locationStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            gpsImage.heightAnchor.constraint(equalToConstant: 20),
            gpsImage.widthAnchor.constraint(equalToConstant: 20),
            
            socialMediaStackView.topAnchor.constraint(equalTo: locationStackView.bottomAnchor, constant: 20),
            socialMediaStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            faceIcon.heightAnchor.constraint(equalToConstant: 20),
            faceIcon.widthAnchor.constraint(equalToConstant: 20),
            twitterIcon.heightAnchor.constraint(equalToConstant: 20),
            twitterIcon.widthAnchor.constraint(equalToConstant: 20),
            linkedInIcon.heightAnchor.constraint(equalToConstant: 20),
            linkedInIcon.widthAnchor.constraint(equalToConstant: 20),
            instagramIcon.heightAnchor.constraint(equalToConstant: 20),
            instagramIcon.widthAnchor.constraint(equalToConstant: 20),
            
            photoSectionTitle.topAnchor.constraint(equalTo: socialMediaStackView.bottomAnchor, constant: 22),
            photoSectionTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            moreButton.topAnchor.constraint(equalTo: socialMediaStackView.bottomAnchor, constant: 20),
            moreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            photosCollectionContainer.topAnchor.constraint(equalTo: photoSectionTitle.bottomAnchor, constant: 10),
            photosCollectionContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            photosCollectionContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            photosCollectionContainer.heightAnchor.constraint(equalToConstant: 180),
            
            photosCollection.topAnchor.constraint(equalTo: photosCollectionContainer.topAnchor, constant: 10),
            photosCollection.leadingAnchor.constraint(equalTo: photosCollectionContainer.leadingAnchor, constant: 10),
            photosCollection.trailingAnchor.constraint(equalTo: photosCollectionContainer.trailingAnchor, constant: -10),
            photosCollection.bottomAnchor.constraint(equalTo: photosCollectionContainer.bottomAnchor, constant: -10),
            
            collectionsSectionTitle.topAnchor.constraint(equalTo: photosCollectionContainer.bottomAnchor, constant: 22),
            collectionsSectionTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            allButton.topAnchor.constraint(equalTo: photosCollectionContainer.bottomAnchor, constant: 20),
            allButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            collectionsCollectionContainer.topAnchor.constraint(equalTo: collectionsSectionTitle.bottomAnchor, constant: 10),
            collectionsCollectionContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionsCollectionContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionsCollectionContainer.heightAnchor.constraint(equalToConstant: 180),
            collectionsCollectionContainer.bottomAnchor.constraint(equalTo: contentGuide.bottomAnchor, constant: -20),
            
            collectionsCollection.topAnchor.constraint(equalTo: collectionsCollectionContainer.topAnchor, constant: 10),
            collectionsCollection.leadingAnchor.constraint(equalTo: collectionsCollectionContainer.leadingAnchor, constant: 10),
            collectionsCollection.trailingAnchor.constraint(equalTo: collectionsCollectionContainer.trailingAnchor, constant: -10),
            collectionsCollection.bottomAnchor.constraint(equalTo: collectionsCollectionContainer.bottomAnchor, constant: -10),
        
        ])
        
        backButton.addTarget(self, action: #selector(backToLastView), for: .touchUpInside)
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.tintColor = .link
        backButton.layer.cornerRadius = 17.5
        backButton.backgroundColor = UIColor.white
        backButton.layer.shadowColor = UIColor.lightGray.cgColor
        backButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        backButton.layer.shadowOpacity = 0.5
        backButton.layer.shadowRadius = 2.0
        backButton.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        backButton.layer.borderWidth = 2
        backButton.layer.masksToBounds = false
        
        messageButton.setTitle("Message", for: .normal)
        messageButton.layer.cornerRadius = (view.frame.width * 0.042)
        
        followButton.backgroundColor = .link
        followButton.setTitle("Follow", for: .normal)
        followButton.layer.cornerRadius = (view.frame.width * 0.042)
        
        viewOfProfileImage.layer.cornerRadius = (view.frame.width * 0.25) / 2
        descriptionLabel.textColor = .lightGray
        
        photosLabel.text = "Photos"
        collectionLabel.text = "Collections"
        likesLabel.text = "Likes"
        
        locationLabel.textColor = .link
        gpsImage.image = UIImage(named: "location")
        
        faceIcon.image = UIImage(named: "facebookIcon")
        faceIcon.tintColor = .lightGray
        twitterIcon.image = UIImage(named: "twitterIcon")
        twitterIcon.tintColor = .lightGray
        linkedInIcon.image = UIImage(named: "linkedinIcon")
        linkedInIcon.tintColor = .lightGray
        instagramIcon.image = UIImage(named: "instagramIcon")
        instagramIcon.tintColor = .lightGray
        
        photoSectionTitle.text = "PHOTOS"
        moreButton.setTitle("More", for: .normal)
        moreButton.setTitleColor(.black, for: .normal)
        
        collectionsSectionTitle.text = "COLLECTIONS"
        allButton.setTitle("All", for: .normal)
        allButton.setTitleColor(.black, for: .normal)
    }
    
    func setupContent() {
        guard let user = user else { return }
        imageOfProfile.kf.setImage(with: URL(string: user.profileImage?.medium ?? ""))
        nameLabel.text = user.name
        descriptionLabel.text = user.bio
        countOfPhotos.text = "\(user.totalPhotos!)"
        countOfCollection.text = "\(user.collections!)"
        countOfLikes.text = "\(user.likes!)"
        messageButton.backgroundColor = user.allowMessage! ? .link : .lightGray.withAlphaComponent(0.5)
        locationLabel.text = user.location
    }
    
    @objc func backToLastView() {
        navigationController?.popViewController(animated: true)
    }
    
    func fetchCollections() {
        guard let user = user else { return }
        NetworkManager.shared.getCollections(userName: user.userName!) { collections in
            self.collections = collections
            self.collectionsCollection.reloadData()
            self.photosCollection.reloadData()
        }
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 2
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return user?.photos!.count ?? 0
        }
        else {
            return collections.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = indexPath.row
        let section = indexPath.section

        let cell:PhotosAndCollectionsCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosAndCollectionsCell.identifier, for: indexPath) as! PhotosAndCollectionsCell

        if section == 0 {
            if let user = user {
                cell.configWithPhoto(user.photos![row])
            }
        }
        else if section == 1 {
            cell.configWithCollection(collections[row])
        }
        return cell
    }
}
