//
//  AuthorLabel.swift
//  PhotosApp
//
//  Created by Eugene on 11.06.2022.
//

import UIKit

class AuthorDetailLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        textAlignment = .left
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAuthor(with name: String) {
        text = name
    }
    
}
