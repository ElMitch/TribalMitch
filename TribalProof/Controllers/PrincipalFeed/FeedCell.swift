//
//  FeedCell.swift
//  TribalWorldWideMitch
//
//  Created by Mitch Samaniego on 23/07/21.
//

import UIKit
import Kingfisher
import RealmSwift
import Realm

class FeedCell: UICollectionViewCell {
    
    static let identifier = "FeedCell"
    
    private var photoOfFeed = UIImageView()
    private var InfoView = UIView()
    private var profilePhoto = UIImageView()
    private var heartImage = UIImageView()
    private var nameLabel = UILabel()
    private var countLabel = UILabel()
    private var favouriteButton = UIImageView()
    private var isLike: Bool = false
    private var isFavourite: Bool = false
    private var photo: Photo!
    private var photoDB: PhotoDB!
    let realm = try! Realm()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        photoOfFeed.translatesAutoresizingMaskIntoConstraints = false
        InfoView.translatesAutoresizingMaskIntoConstraints = false
        profilePhoto.translatesAutoresizingMaskIntoConstraints = false
        heartImage.translatesAutoresizingMaskIntoConstraints = false
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        let labelsStackView = UIStackView(arrangedSubviews: [nameLabel, countLabel])
        labelsStackView.axis = .vertical
        labelsStackView.distribution = .fill
        labelsStackView.alignment = .leading
        labelsStackView.spacing = 0
        
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        photoOfFeed.contentMode = .scaleToFill
        
        contentView.insertSubview(photoOfFeed, at: 0)
        contentView.addSubview(InfoView)
        InfoView.addSubview(favouriteButton)
        InfoView.addSubview(profilePhoto)
        InfoView.addSubview(heartImage)
        InfoView.addSubview(labelsStackView)
        
        NSLayoutConstraint.activate([
            
            photoOfFeed.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            photoOfFeed.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            photoOfFeed.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            photoOfFeed.heightAnchor.constraint(equalToConstant: 200),
            
            favouriteButton.topAnchor.constraint(equalTo: InfoView.topAnchor, constant: 10),
            favouriteButton.trailingAnchor.constraint(equalTo: InfoView.trailingAnchor, constant: -10),
            favouriteButton.heightAnchor.constraint(equalToConstant: 30),
            favouriteButton.widthAnchor.constraint(equalToConstant: 30),
            
            InfoView.topAnchor.constraint(equalTo: photoOfFeed.bottomAnchor, constant: 0),
            InfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            InfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            InfoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            profilePhoto.heightAnchor.constraint(equalToConstant: 40),
            profilePhoto.widthAnchor.constraint(equalToConstant: 40),
            profilePhoto.centerYAnchor.constraint(equalTo: InfoView.centerYAnchor, constant: 0),
            profilePhoto.leadingAnchor.constraint(equalTo: InfoView.leadingAnchor, constant: 10),
            
            labelsStackView.centerYAnchor.constraint(equalTo: InfoView.centerYAnchor, constant: 0),
            labelsStackView.leadingAnchor.constraint(equalTo: profilePhoto.trailingAnchor, constant: 10),
            labelsStackView.topAnchor.constraint(equalTo: photoOfFeed.bottomAnchor, constant: 10),
            labelsStackView.bottomAnchor.constraint(equalTo: InfoView.bottomAnchor, constant: -10),
            
            heartImage.heightAnchor.constraint(equalToConstant: 30),
            heartImage.widthAnchor.constraint(equalToConstant: 30),
            heartImage.trailingAnchor.constraint(equalTo: InfoView.trailingAnchor, constant: -10),
            heartImage.leadingAnchor.constraint(equalTo: labelsStackView.trailingAnchor, constant: 10),
            heartImage.bottomAnchor.constraint(equalTo: InfoView.bottomAnchor, constant: -10)
            
        ])
        
        
        InfoView.layer.cornerRadius = 10
        InfoView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        contentView.backgroundColor = .clear
        profilePhoto.layer.cornerRadius = 20
        nameLabel.numberOfLines = 0
        heartImage.isUserInteractionEnabled = true
        heartImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(likeTapped(tapGestureRecognizer:))))
        heartImage.image = UIImage(systemName: "heart")
        favouriteButton.image = UIImage(systemName: "star")
        favouriteButton.tintColor = .link
        favouriteButton.isUserInteractionEnabled = true
        favouriteButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(favouriteTapped(tapGestureRecognizer:))))
    }
    
    func configWith(_ photo: Photo) {
        self.photo = photo
        profilePhoto.backgroundColor = .purple
        DispatchQueue.main.async {
            self.photoOfFeed.kf.setImage(with: URL(string: photo.urls?.full ?? ""))
            self.profilePhoto.kf.setImage(with: URL(string: photo.user?.profileImage?.medium ?? ""))
        }
        photoOfFeed.layer.cornerRadius = 10
        photoOfFeed.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        InfoView.backgroundColor = .white
        
        nameLabel.text = photo.altDescription
        countLabel.text = "\(photo.likes ?? 0) Me gusta"
    }
    
    func configWithDB(_ photo: PhotoDB) {
        self.photoDB = photo
        
        photoOfFeed.image = UIImage(data: photo.urls as! Data)
        profilePhoto.image = UIImage(data: photo.profileImage as! Data)
        photoOfFeed.layer.cornerRadius = 10
        photoOfFeed.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        InfoView.backgroundColor = .white
        
        nameLabel.text = photo.altDescription
        countLabel.isHidden = true
        favouriteButton.image = UIImage(systemName: "star.fill")
        isFavourite = true
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func likeTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        toggleImageAppearence()
    }
    
    private func toggleImageAppearence() {
        isLike.toggle()
        heartImage.image = isLike ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        heartImage.tintColor = isLike ? .red : .link
        photo.likes = isLike ? photo.likes! + 1 : photo.likes! - 1
        countLabel.text = "\(photo.likes!) Me gusta"
      }
    
    @objc func favouriteTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        toggleFavouriteAppearence()
    }
    
    private func toggleFavouriteAppearence() {
        isFavourite.toggle()
        favouriteButton.image = isFavourite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        if isFavourite {
            let favourite = PhotoDB()
            if let profileData = NSData(contentsOf: URL(string: photo.user?.profileImage?.medium ?? "")!) {
                favourite.profileImage = profileData
            }
            if let photoImage = NSData(contentsOf: URL(string: photo.urls?.full ?? "")!) {
                favourite.urls = photoImage
            }
            favourite.altDescription = photo.altDescription ?? ""
            favourite.id = photo.id ?? ""
            realm.beginWrite()
            realm.add(favourite)
            try! realm.commitWrite()
        } else {
            realm.beginWrite()
            realm.delete(photoDB)
            try! realm.commitWrite()
        }
    }
    
}
