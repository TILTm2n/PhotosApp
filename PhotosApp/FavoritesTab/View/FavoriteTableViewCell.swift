//
//  FavoriteTableViewCell.swift
//  PhotosApp
//
//  Created by Eugene on 12.06.2022.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    static let identifier = "FavoriteTableViewCell"
    
    private var favoriteImageView: FavoriteImageView?
    private var authorNameLbl: AuthorFavoriteLabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let image = FavoriteImageView()
        let authName = AuthorFavoriteLabel()
        
        image.layer.cornerRadius = 50
        
        translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(image)
        contentView.addSubview(authName)
        
        favoriteImageView = image
        authorNameLbl = authName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        
        guard let favoriteImageView = favoriteImageView, let authorNameLbl = authorNameLbl else { return }

        NSLayoutConstraint.activate([
            favoriteImageView.widthAnchor.constraint(equalToConstant: 100),
            favoriteImageView.heightAnchor.constraint(equalToConstant: 100),
            favoriteImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            favoriteImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            favoriteImageView.layoutMarginsGuide.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            
            authorNameLbl.heightAnchor.constraint(equalToConstant: 50),
            authorNameLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            authorNameLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            authorNameLbl.leadingAnchor.constraint(equalTo: favoriteImageView.trailingAnchor, constant: 20)
        ])
    }
    
    func configureCell(with url: String?, and name: String?){
        self.favoriteImageView?.setImage(with: url)
        self.authorNameLbl?.setAuthor(with: name ?? "Unnamed")
    }
}
