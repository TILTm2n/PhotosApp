//
//  SearchBuilder.swift
//  PhotosApp
//
//  Created by Eugene on 11.06.2022.
//

import Foundation
import UIKit

class Builder {
    
    static func buildSearchModule() -> UIViewController{
        let view = SearchController()
        let networkManager = NetworkManager()
        let presenter = SearchPresenter(with: view, network: networkManager)
        view.presenter = presenter
        return view
    }
    
    static func buildDetailModule(information: Information?, favorite: FavoritePhoto?, senderVC: SenderViewControllerProtocol?, isSaver: Bool) -> UIViewController {
        let view = DetailController()
        let storage = StorageManager()
        let presenter = DetailPresenter(view: view, info: information, storageManager: storage)
        presenter.favoritePhoto = favorite
        presenter.senderVC = senderVC
        presenter.isSaver = isSaver
        view.presenter = presenter
        return view
    }
    
    static func buildFavoriteModule() -> UIViewController {
        let view = FavoriteController()
        let storageManager = StorageManager()
        let presenter = FavoritePresenter(view, storageManager)
        view.presenter = presenter
        return view
    }
    
}
