//
//  PhotosAndCollectionsCell.swift
//  TribalWorldWideMitch
//
//  Created by Mitch Samaniego on 24/07/21.
//

import UIKit
import Kingfisher

class PhotosAndCollectionsCell: UICollectionViewCell {
    
    enum TypeOfCollection {
        case photo
        case collection
    }
    
    static let identifier = "PhotosAndCollectionsCell"
    
    private var photoOfFeed = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        photoOfFeed.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(photoOfFeed)
        
        NSLayoutConstraint.activate([
            
            photoOfFeed.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            photoOfFeed.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            photoOfFeed.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            photoOfFeed.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
            
        ])
        
        contentView.backgroundColor = .clear
    }
    
    func configWithPhoto(_ photo: UserPhotos) {
        DispatchQueue.main.async {
            self.photoOfFeed.kf.setImage(with: URL(string: photo.urls?.full ?? ""))
        }
    }
    
    func configWithCollection(_ collection: Collections) {
        DispatchQueue.main.async {
            self.photoOfFeed.kf.setImage(with: URL(string: collection.coverPhoto?.urls?.full ?? ""))
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

