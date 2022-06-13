//
//  APIResponse.swift
//  PhotosApp
//
//  Created by Eugene on 10.06.2022.
//

import Foundation

struct APIResponse: Codable {
    var results: [Item]
}

struct Item: Codable {
    var description: String?
    var created_at: String
    var urls: Urls
    var user: Author
    var likes: Int16
}

struct Urls: Codable {
    var full: String
    var regular: String
    var small: String
}

struct Author: Codable {
    var name: String
    var location: String?
}


