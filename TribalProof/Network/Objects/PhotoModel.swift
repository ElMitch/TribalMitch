//
//  PhotoModel.swift
//  TribalWorldWideMitch
//
//  Created by Mitch Samaniego on 24/07/21.
//

import UIKit

struct Photo: Codable, Hashable {
    let id: String?
    var createdAt: String?
    let altDescription: String?
    let urls: URLs?
    var likes: Int?
    let likedByUser: Bool?
    let user: User?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case altDescription = "alt_description"
        case urls
        case likes
        case likedByUser = "liked_by_user"
        case user
    }
}

struct URLs: Codable, Hashable {
    let raw: String?
    let full: String?
    let regular: String?
    let small: String?
    let thumb: String?
    
    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
    }
}

struct User: Codable, Hashable {
    let id: String?
    let userName: String?
    let name: String?
    let location: String?
    let bio: String?
    let profileImage: ProfileImage?
    let social: Social?
    let collections: Int?
    let likes: Int?
    let totalPhotos: Int?
    let allowMessage: Bool?
    let photos: [UserPhotos]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, location, bio, photos
        case profileImage = "profile_image"
        case userName = "username"
        case social
        case collections = "total_collections"
        case likes = "total_likes"
        case totalPhotos = "total_photos"
        case allowMessage = "allow_messages"
    }
}

struct UserPhotos: Codable, Hashable {
    let id: String?
    var createdAt: String?
    let urls: URLs?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case urls
    }
}

struct ProfileImage: Codable, Hashable {
    let small, medium, large: String?
    
    enum CodingKeys: String, CodingKey {
        case small, medium, large
    }
}

struct Social: Codable, Hashable {
    let instagram: String?
    let twitter: String?
    
    enum CodingKeys: String, CodingKey {
        case instagram, twitter
    }
}

struct Collections: Codable, Hashable {
    let title: String?
    let coverPhoto: CoverPhoto?
    
    
    enum CodingKeys: String, CodingKey {
        case title
        case coverPhoto = "cover_photo"
    }
}

struct CoverPhoto: Codable, Hashable {
    let urls: URLs?
    
    enum CodingKeys: String, CodingKey {
        case urls
    }
}
