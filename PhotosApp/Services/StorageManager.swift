//
//  StorageManager.swift
//  PhotosApp
//
//  Created by Eugene on 12.06.2022.
//

import UIKit
import Foundation

// TODO: private проставлять в методах и переменных везде, где нужно

protocol StorageManagerProtocol {
    func addPhoto(info: Information?)
    func getPhotos() -> [FavoritePhoto]
    func deletePhoto(photoToDelete: FavoritePhoto)
}

class StorageManager: StorageManagerProtocol {
    
    // TODO: убрать опционал
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func addPhoto(info: Information?) {
        guard let info = info else { return }

        let newPhoto = FavoritePhoto(context: context)
        newPhoto.photoUrl = info.imageUrl
        newPhoto.author = info.authorName
        newPhoto.date = info.createdDate
        newPhoto.location = info.location
        newPhoto.likes = info.likes
        
        do {
            try context.save()
        } catch let error {
            print(error)
        }
    }
    
    func getPhotos() -> [FavoritePhoto]{
        var favoritePfotos: [FavoritePhoto] = []

        do {
            favoritePfotos = try context.fetch(FavoritePhoto.fetchRequest())
        } catch let error {
            print(error)
        }

        return favoritePfotos
    }
    
    func deletePhoto(photoToDelete: FavoritePhoto) {
        context.delete(photoToDelete)
        
        do {
            try context.save()
        } catch let error {
            print(error)
        }
    }
    
}
