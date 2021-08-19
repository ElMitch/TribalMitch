//
//  ImageDetailViewController.swift
//  TribalWorldWideMitch
//
//  Created by Mitch Samaniego on 24/07/21.
//

import UIKit
import Kingfisher

class ImageDetailViewController: UIViewController {
    
    private let photoImage = UIImageView()
    private let contentView = UIView()
    private let profileImage = UIImageView()
    private let photoDescription = UILabel()
    private let date = UILabel()
    private let userName = UILabel()
    private let likes = UILabel()
    var photo: Photo!
    var ViewIsHidde: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setInformation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNav()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setupNav() {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Perfil", style: .plain, target: self, action: #selector(profileTapped))
    }
    
    func setupView() {
        view.backgroundColor = .black
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        date.translatesAutoresizingMaskIntoConstraints = false
        userName.translatesAutoresizingMaskIntoConstraints = false
        likes.translatesAutoresizingMaskIntoConstraints = false
        photoImage.contentMode = .scaleToFill
        photoDescription.numberOfLines = 0
        photoDescription.textColor = .white
        date.numberOfLines = 0
        date.textColor = .white
        userName.numberOfLines = 0
        userName.textColor = .white
        
        view.insertSubview(photoImage, at: 0)
        view.addSubview(contentView)
        contentView.addSubview(profileImage)
        
        let labelsStackView = UIStackView(arrangedSubviews: [photoDescription, date, userName])
        labelsStackView.axis = .vertical
        labelsStackView.distribution = .fillEqually
        labelsStackView.alignment = .leading
        labelsStackView.spacing = 0
        
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelsStackView)
        
        NSLayoutConstraint.activate([
        
            photoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            photoImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            photoImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            photoImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            contentView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.30),
            
            profileImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            profileImage.heightAnchor.constraint(equalToConstant: 50),
            profileImage.widthAnchor.constraint(equalToConstant: 50),
            
            labelsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            labelsStackView.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20),
            labelsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            labelsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            
        ])
        contentView.backgroundColor = .white.withAlphaComponent(0.2)
        let tap = UITapGestureRecognizer(target: self, action: #selector(showButtonsInTap))
        self.view.addGestureRecognizer(tap)
        self.view.isUserInteractionEnabled = true
        
        profileImage.isUserInteractionEnabled = true
    }
    
    func setInformation() {
        photoImage.kf.setImage(with: URL(string: photo.urls?.full ?? ""))
        profileImage.kf.setImage(with: URL(string: photo.user?.profileImage?.medium ?? ""))
        photoDescription.text = photo.altDescription
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale.current
        let dateString = photo.createdAt?.prefix(10)
        let stringToDate = dateFormatter.date(from: String(dateString!))
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let dateToString = dateFormatter.string(from: stringToDate!)
        date.text = "Creada: \(dateToString)"
        userName.text = "Por: \(photo.user?.name != nil ? photo.user?.name ?? "" : photo.user?.userName ?? "" )"
    }
    
    @objc func profileTapped() {
        let profile = ProfileViewController()
        NetworkManager.shared.getProfile(userName: photo.user?.userName ?? "") { user in
            profile.user = user
            self.navigationController?.pushViewController(profile, animated: true)
        }
        
    }
    
    @objc func showButtonsInTap() {
        if ViewIsHidde {
            showView()
        } else {
            hiddeView()
        }
        ViewIsHidde.toggle()
    }
    
    func showView() {
        UIView.animate(withDuration: 1) {
            self.contentView.isHidden = false
            self.navigationController?.navigationBar.isHidden = false
            self.view.layoutIfNeeded()
        }
    }
    
    func hiddeView() {
        UIView.animate(withDuration: 1) {
            self.contentView.isHidden = true
            self.navigationController?.navigationBar.isHidden = true
            self.view.layoutIfNeeded()
        }
    }
    
    
}
