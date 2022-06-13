//
//  SearchPresenter.swift
//  PhotosApp
//
//  Created by Eugene on 10.06.2022.
//

import Foundation

protocol SearchPresenterProtocol: AnyObject {
    var items: [Item]? { get set }
    func getItems(with query: String)
    init(with view: SearchViewProtocol, network manager: NetworkManagerProtocol)
}

class SearchPresenter: SearchPresenterProtocol {
    
    var items: [Item]?
    weak var view: SearchViewProtocol?
    var networkManager: NetworkManagerProtocol
    
    required init(with view: SearchViewProtocol, network manager: NetworkManagerProtocol) {
        self.view = view
        self.networkManager = manager
        getItems(with: "London")
    }
    
    func getItems(with query: String) {
        networkManager.fetchPhotos(with: query) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result{
                case .success(let items):
                    self.items = items
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    
}
