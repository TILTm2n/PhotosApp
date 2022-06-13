//
//  SearchController.swift
//  PhotosApp
//
//  Created by Eugene on 10.06.2022.
//

import UIKit

protocol SearchViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

class SearchController: UIViewController, UISearchBarDelegate {
    
    var presenter: SearchPresenterProtocol?

    private var collectionView: UICollectionView?
    
    let searchBar = UISearchBar()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "light")
        
        searchBar.delegate = self
        searchBar.searchTextField.layer.cornerRadius = 20
        view.addSubview(searchBar)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SearchCollectionCell.self, forCellWithReuseIdentifier: SearchCollectionCell.identifier)
        collectionView.backgroundColor = UIColor(named: "light")
        view.addSubview(collectionView)
        self.collectionView = collectionView
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchBar.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.size.width, height: 50)
        collectionView?.frame = CGRect(x: 0, y: view.safeAreaInsets.top + 50, width: view.frame.size.width, height: view.frame.size.height - 55)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        presenter?.getItems(with: searchBar.text ?? "")
    }
    
}

extension SearchController: SearchViewProtocol {
    
    func success() {
        collectionView?.reloadData()
    }
    
    func failure(error: Error) {
        let alert = UIAlertController(title: "Unable to get data", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    func emptyArrayAlert(){
        let alert = UIAlertController(title: "Couldn't find photo!", message: "Let's try again", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    func notFoundInfo(){
        let alert = UIAlertController(title: "Couldn't find information!", message: "Let's try another photo", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        //Item
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(2/3),
            heightDimension: .fractionalWidth(0.6))
        )
        let verticalStackItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1/2))
        )
        
        //Group
        let verticalStackGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                               heightDimension: .fractionalHeight(1)),
            subitem: verticalStackItem,
            count: 2)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(3/5)),
            subitems: [
                item,
                verticalStackGroup
            ])
        
        //Sections
        let section = NSCollectionLayoutSection(group: group)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        verticalStackItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        //return
        return UICollectionViewCompositionalLayout(section: section)
    }
    
}

extension SearchController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionCell.identifier, for: indexPath) as? SearchCollectionCell, let items = self.presenter?.items else {
            return SearchCollectionCell()
        }
        
        if presenter?.items?.count == 0 {
            self.emptyArrayAlert()
        }
        
        cell.setImage(with: items[indexPath.row].urls.regular)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if let result = self.presenter?.items?[indexPath.row] {
            let info = Information(likes: result.likes, location: result.user.location, imageUrl: result.urls.regular, authorName: result.user.name, createdDate: result.created_at)
            let detailVC = Builder.buildDetailModule(information: info, favorite: nil, senderVC: nil, isSaver: true)
            
            self.present(detailVC, animated: true)
        }
        
        self.notFoundInfo()
    }
    
}
