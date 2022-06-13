//
//  DetailPresenter.swift
//  PhotosApp
//
//  Created by Eugene on 11.06.2022.
//

import Foundation

protocol DetailPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, info: Information?, storageManager: StorageManagerProtocol)
    func setInformation()
    func setFavorite()
    func savePhoto()
    func deletePhoto()
    var information: Information? { get set }
    var favoritePhoto: FavoritePhoto? { get set }
    var senderVC: SenderViewControllerProtocol? { get set }
    var isSaver: Bool { get set }
}

class DetailPresenter: DetailPresenterProtocol {
    
    weak var detailView: DetailViewProtocol?
    var information: Information?
    var favoritePhoto: FavoritePhoto?
    var storage: StorageManagerProtocol
    var senderVC: SenderViewControllerProtocol?
    var isSaver: Bool = true
    
    required init(view: DetailViewProtocol, info: Information?, storageManager: StorageManagerProtocol) {
        detailView = view
        information = info
        storage = storageManager
    }
    
    func setInformation() {
        detailView?.setInformation(with: information)
    }
    
    func setFavorite(){
        detailView?.setFavorite(with: favoritePhoto)
    }
    
    func savePhoto(){
        if let information = information {
            storage.addPhoto(info: information)
            senderVC?.updateData()
        } else {
            detailView?.addError()
        }
    }
    
    func deletePhoto(){
        if let favoritePhoto = favoritePhoto {
            storage.deletePhoto(photoToDelete: favoritePhoto)
            senderVC?.updateData()
        } else {
            detailView?.deleteError()
        }
        
    }
    
}
