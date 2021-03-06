//
//  LikesLabel.swift
//  PhotosApp
//
//  Created by Eugene on 11.06.2022.
//

import UIKit

// TODO: убрать везде public и open (если open тоже есть), т.к. ты работаешь в рамках одного модуля

class LikesLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        textAlignment = .left
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setLikes(with amount: Int16) {
        text = "\(amount)"
    }

}
