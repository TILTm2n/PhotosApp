//
//  DetailController.swift
//  PhotosApp
//
//  Created by Eugene on 11.06.2022.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    func setInformation(with info: Information?)
    func setFavorite(with favoritePhoto: FavoritePhoto?)
    func deleteError()
    func addError()
}

class DetailController: UIViewController {

    var presenter: DetailPresenterProtocol?
    var navBar: UINavigationBar!
    var imgView: DetailImageView!
    var authorLbl: AuthorDetailLabel!
    var likesLbl: LikesLabel!
    var dateLbl: DateLabel!
    var locLbl: LocationLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad from DetailController")
        view.backgroundColor = UIColor(named: "light")
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhoto))
        let navigationBar = UINavigationBar(frame: .zero)
        let navigationItem = UINavigationItem(title: "Information")
        
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.backgroundColor = UIColor(named: "light")
        navigationItem.rightBarButtonItem = addButton
        navigationBar.setItems([navigationItem], animated: true)
        
        let imageView = DetailImageView()
        let authLabel = AuthorDetailLabel()
        let dateLabel = DateLabel()
        let locLabel = LocationLabel()
        let likesLabel = LikesLabel()
        
        view.addSubview(navigationBar)
        view.addSubview(likesLabel)
        view.addSubview(imageView)
        view.addSubview(dateLabel)
        view.addSubview(authLabel)
        view.addSubview(locLabel)
        
        navBar = navigationBar
        likesLbl = likesLabel
        authorLbl = authLabel
        imgView = imageView
        dateLbl = dateLabel
        locLbl = locLabel
        
        setConstraints()
        
        if let presenter = presenter {
            
            if !presenter.isSaver {
                let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deletePhoto))
                navigationItem.leftBarButtonItem = deleteButton
            }
            
            if let _ = presenter.information{
                presenter.setInformation()
            }
            
            if let _ = presenter.favoritePhoto {
                presenter.setFavorite()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear from DetailController")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear from DetailController")
    }
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            navBar.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            navBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            navBar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            imgView.heightAnchor.constraint(equalToConstant: 300),
            imgView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            imgView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            imgView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            authorLbl.topAnchor.constraint(equalTo: imgView.bottomAnchor),
            authorLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authorLbl.heightAnchor.constraint(equalToConstant: 50),
            
            locLbl.topAnchor.constraint(equalTo: authorLbl.bottomAnchor),
            locLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            locLbl.heightAnchor.constraint(equalToConstant: 50),
            
            dateLbl.topAnchor.constraint(equalTo: locLbl.bottomAnchor),
            dateLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateLbl.heightAnchor.constraint(equalToConstant: 50),
            
            likesLbl.topAnchor.constraint(equalTo: dateLbl.bottomAnchor),
            likesLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            likesLbl.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc func addPhoto() {
        presenter?.savePhoto()
        dismiss(animated: true)
    }
    
    @objc func deletePhoto() {
        presenter?.deletePhoto()
        dismiss(animated: true)
    }
    
    func addError(){
        let alert = UIAlertController(title: "Placed in storage", message: "Already added", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func deleteError(){
        let alert = UIAlertController(title: "Empty", message: "Nothing to delete", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
}

extension DetailController: DetailViewProtocol {
    
    func setInformation(with info: Information?) {
        guard let info = info else { return }
        authorLbl.setAuthor(with: info.authorName)
        dateLbl.setDate(created: info.createdDate)
        locLbl.setLocation(with: info.location ?? "Location not found")
        imgView.setImage(with: info.imageUrl)
        likesLbl.setLikes(with: info.likes)
    }
    
    func setFavorite(with favoritePhoto: FavoritePhoto?) {
        guard let favoritePhoto = favoritePhoto else { return }
        authorLbl.setAuthor(with: favoritePhoto.author ?? "Author not found")
        dateLbl.setDate(created: favoritePhoto.date ?? "")
        locLbl.setLocation(with: favoritePhoto.location ?? "Location not found")
        imgView.setImage(with: favoritePhoto.photoUrl)
        likesLbl.setLikes(with: favoritePhoto.likes)
    }
    
}
