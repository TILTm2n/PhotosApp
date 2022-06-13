//
//  FavoriteController.swift
//  PhotosApp
//
//  Created by Eugene on 12.06.2022.
//

import UIKit

protocol FavoriteViewProtocol: AnyObject {
    func setPhotos()
}

protocol SenderViewControllerProtocol: AnyObject {
    func updateData()
}

class FavoriteController: UIViewController, FavoriteViewProtocol {

    var presenter: FavoritePresenterProtocol?
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites Photos"
        view.backgroundColor = UIColor(named: "light")
        let favoriteTableView = UITableView()
        favoriteTableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.identifier)
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.rowHeight = 100
        view.addSubview(favoriteTableView)
        tableView =  favoriteTableView
        presenter?.updateItems()
        tableView?.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.updateItems()
    }
    
    override func viewDidLayoutSubviews() {
        tableView?.frame = view.bounds
    }
    
    func setPhotos() {
        tableView?.reloadData()
    }
    
    
}
extension FavoriteController: UITableViewDelegate, UITableViewDataSource, SenderViewControllerProtocol {
    
    func updateData() {
        presenter?.updateItems()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier) as? FavoriteTableViewCell else {
            return FavoriteTableViewCell()
        }
        
        if let presenter = presenter, let items = presenter.items {
            cell.configureCell(with: items[indexPath.row].photoUrl, and: items[indexPath.row].author)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let result = self.presenter?.items?[indexPath.row] {
            
            let detailVC = Builder.buildDetailModule(information: nil, favorite: result, senderVC: self, isSaver: false)
            self.present(detailVC, animated: true)
        }
        
    }
    
}
