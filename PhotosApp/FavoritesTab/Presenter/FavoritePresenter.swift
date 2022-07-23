//
//  FavoritePresenter.swift
//  PhotosApp
//
//  Created by Eugene on 12.06.2022.
//

import Foundation

protocol FavoritePresenterProtocol: AnyObject {
    init(_ view: FavoriteViewProtocol, _ storageManager: StorageManagerProtocol)
    func updateItems()
    var items: [FavoritePhoto]? { get set }
}
 
class FavoritePresenter: FavoritePresenterProtocol {
    
    var items: [FavoritePhoto]? // TODO: private поставить, вроде локально только используется
    weak var view: FavoriteViewProtocol?
    var storage: StorageManagerProtocol?
    
    required init(_ favoriteView: FavoriteViewProtocol, _ storageManager: StorageManagerProtocol) {
        view = favoriteView
        storage = storageManager
        
        if let storage = storage {
            items = storage.getPhotos()
        }
    }
    
    func updateItems() {
        items = storage?.getPhotos()
        view?.setPhotos()
    }
    
}
