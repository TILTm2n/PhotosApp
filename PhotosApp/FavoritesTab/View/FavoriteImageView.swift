//
//  FavoriteImageView.swift
//  PhotosApp
//
//  Created by Eugene on 12.06.2022.
//

import UIKit

class FavoriteImageView: UIImageView {

    init() {
        super.init(image: UIImage(named: "default"))
        
        clipsToBounds = true
        contentMode = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(with url: String?) {
        if let url = url {
            self.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "default"))
        }
    }
    
}
