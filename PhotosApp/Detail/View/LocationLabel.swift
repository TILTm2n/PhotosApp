//
//  LocationLabel.swift
//  PhotosApp
//
//  Created by Eugene on 11.06.2022.
//

import UIKit

// TODO: с лейблами Date, Likes, Location и т.п. не нужны классы, их лучше в нужном вью контроллеры определить
class LocationLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        textAlignment = .left
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // TODO: методы особо не нужны, т.к. можно просто обратиться через ...label.text = ""
    public func setLocation(with name: String) {
        text = name
    }

}
