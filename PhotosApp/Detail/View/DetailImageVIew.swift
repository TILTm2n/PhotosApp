//
//  DetailImageVIew.swift
//  PhotosApp
//
//  Created by Eugene on 11.06.2022.
//

import UIKit
import SDWebImage

class DetailImageView: UIImageView {

    init() {
        super.init(image: UIImage(named: "default"))
        clipsToBounds = true
        contentMode = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    public func setImage(with url: String?) {
        self.sd_setImage(with: URL(string: url ?? ""), placeholderImage: UIImage(named: "default"))
    }
    
}
