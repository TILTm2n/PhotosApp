//
//  Information.swift
//  PhotosApp
//
//  Created by Eugene on 11.06.2022.
//

import Foundation

struct Information {
    var likes: Int16 // TODO: посмотреть, вроде как можно просто через Int, либо поменять в моделе
    var location: String?
    var imageUrl: String?
    var authorName: String
    var createdDate: String
}
