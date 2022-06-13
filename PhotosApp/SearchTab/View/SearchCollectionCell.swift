//
//  SearchCollectionCell.swift
//  PhotosApp
//
//  Created by Eugene on 11.06.2022.
//

import UIKit
import SDWebImage

class SearchCollectionCell: UICollectionViewCell {
    static let identifier = "SearchCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.addSubview(imageView)
        setImage(with: "")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func setImage(with url: String){
        self.imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "default"))
    }
}
